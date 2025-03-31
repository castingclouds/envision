# config/initializers/warden.rb
# Custom Warden strategies for team-based authentication

Rails.application.config.middleware.use Warden::Manager do |manager|
  manager.default_strategies :database_authenticatable
  manager.failure_app = Devise::FailureApp
end

# Add a custom Warden strategy for team authentication
Warden::Strategies.add(:team_authenticatable) do
  def valid?
    params['user'] && params['user']['username'] && params['user']['password'] && params['team_id']
  end

  def authenticate!
    user = User.authenticate(params['user']['username'], params['user']['password'])
    
    if user.nil?
      fail!("Invalid username or password")
      return
    end
    
    team = Team.find_by(id: params['team_id'])
    if team.nil?
      fail!("Invalid team")
      return
    end
    
    # Check if user is a member of the team
    membership = TeamMembership.find_by(user: user, team: team)
    if membership.nil?
      fail!("You are not a member of this team")
      return
    end
    
    # Store the current team in the session
    session[:current_team_id] = team.id
    
    # Successful authentication
    success!(user)
  end
end

# Add helper methods to access the current team
Warden::Manager.after_set_user do |_user, auth, _opts|
  if auth.session[:current_team_id]
    team = Team.find_by(id: auth.session[:current_team_id])
    auth.session[:current_team] = team if team
  end
end
