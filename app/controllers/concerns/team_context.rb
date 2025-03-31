# app/controllers/concerns/team_context.rb
module TeamContext
  extend ActiveSupport::Concern

  included do
    helper_method :current_team, :current_team_membership if respond_to?(:helper_method)
    before_action :set_team_context
  end

  # Get the current team from the session
  def current_team
    @current_team ||= begin
      if session[:current_team_id].present?
        Team.find_by(id: session[:current_team_id])
      end
    end
  end

  # Get the current user's membership in the current team
  def current_team_membership
    @current_team_membership ||= begin
      if current_user && current_team
        TeamMembership.find_by(user: current_user, team: current_team)
      end
    end
  end

  # Check if the current user is an admin of the current team
  def team_admin?
    current_team_membership&.admin?
  end

  # Check if the current user is a member of the current team
  def team_member?
    current_team_membership.present?
  end

  # Set the current team context
  def set_team_context
    # If a team_id parameter is provided and the user is a member of that team,
    # update the current team in the session
    if params[:team_id].present? && current_user
      team = Team.find_by(id: params[:team_id])
      if team && current_user.teams.include?(team)
        session[:current_team_id] = team.id
        @current_team = team
      end
    end
  end

  # Switch to a different team
  def switch_team(team)
    if team && current_user.teams.include?(team)
      session[:current_team_id] = team.id
      @current_team = team
      @current_team_membership = nil
      return true
    end
    false
  end
end
