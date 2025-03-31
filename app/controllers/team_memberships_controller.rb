class TeamMembershipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_team
  before_action :set_team_membership, only: [:update, :destroy]
  before_action :authorize_team_admin!

  # GET /teams/:team_id/members
  def index
    @team_memberships = @team.team_memberships.includes(:user)
    @new_team_membership = TeamMembership.new
  end

  # POST /teams/:team_id/members
  def create
    # Find the user by email or username
    user = User.find_by(email: params[:email]) || User.find_by(username: params[:username])
    
    if user.nil?
      redirect_to team_team_memberships_path(@team), alert: 'User not found.'
      return
    end
    
    # Check if the user is already a member of the team
    if @team.users.include?(user)
      redirect_to team_team_memberships_path(@team), alert: 'User is already a member of this team.'
      return
    end
    
    # Add the user to the team with the specified role
    @team_membership = @team.team_memberships.new(user: user, role: params[:role] || 'member')
    
    if @team_membership.save
      redirect_to team_team_memberships_path(@team), notice: 'User was successfully added to the team.'
    else
      redirect_to team_team_memberships_path(@team), alert: 'Failed to add user to the team.'
    end
  end

  # PATCH/PUT /teams/:team_id/members/:id
  def update
    if @team_membership.update(team_membership_params)
      redirect_to team_team_memberships_path(@team), notice: 'Member role was successfully updated.'
    else
      redirect_to team_team_memberships_path(@team), alert: 'Failed to update member role.'
    end
  end

  # DELETE /teams/:team_id/members/:id
  def destroy
    # Don't allow removing the last admin
    if @team_membership.admin? && @team.team_memberships.admins.count == 1
      redirect_to team_team_memberships_path(@team), alert: 'Cannot remove the last admin from the team.'
      return
    end
    
    @team_membership.destroy
    redirect_to team_team_memberships_path(@team), notice: 'Member was successfully removed from the team.'
  end

  private
  
  # Use callbacks to share common setup or constraints between actions
  def set_team
    @team = Team.find(params[:team_id])
  end
  
  def set_team_membership
    @team_membership = @team.team_memberships.find(params[:id])
  end
  
  # Only allow a list of trusted parameters through
  def team_membership_params
    params.require(:team_membership).permit(:role)
  end
  
  # Check if the current user is an admin of the team
  def authorize_team_admin!
    membership = current_user.team_memberships.find_by(team: @team)
    unless membership&.admin?
      redirect_to teams_path, alert: 'You are not authorized to perform this action.'
    end
  end
end
