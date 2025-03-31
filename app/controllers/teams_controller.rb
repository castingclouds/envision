class TeamsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_team, only: [:show, :edit, :update, :destroy, :join, :leave]
  before_action :authorize_team_admin!, only: [:edit, :update, :destroy]

  # GET /teams
  def index
    @teams = current_user.teams.includes(:team_memberships)
  end

  # GET /teams/1
  def show
    @team_membership = current_user.team_memberships.find_by(team: @team)
  end

  # GET /teams/new
  def new
    @team = Team.new
  end

  # POST /teams
  def create
    @team = Team.new(team_params)

    if @team.save
      # Add the current user as an admin of the team
      @team.team_memberships.create(user: current_user, role: 'admin')
      
      # Set this as the current team
      switch_team(@team)
      
      redirect_to @team, notice: 'Team was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET /teams/1/edit
  def edit
  end

  # PATCH/PUT /teams/1
  def update
    if @team.update(team_params)
      redirect_to @team, notice: 'Team was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /teams/1
  def destroy
    @team.destroy
    redirect_to teams_url, notice: 'Team was successfully deleted.'
  end

  # POST /teams/1/join
  def join
    # Check if the user is already a member of the team
    if current_user.teams.include?(@team)
      redirect_to @team, notice: 'You are already a member of this team.'
      return
    end

    # Add the user to the team as a member
    @team.team_memberships.create(user: current_user, role: 'member')
    
    # Set this as the current team
    switch_team(@team)
    
    redirect_to @team, notice: 'You have successfully joined the team.'
  end

  # DELETE /teams/1/leave
  def leave
    membership = current_user.team_memberships.find_by(team: @team)
    
    if membership&.admin? && @team.team_memberships.admins.count == 1
      redirect_to @team, alert: 'You cannot leave the team as you are the only admin.'
      return
    end
    
    membership&.destroy
    
    # If this was the current team, reset the current team
    if current_team == @team
      session[:current_team_id] = nil
    end
    
    redirect_to teams_path, notice: 'You have successfully left the team.'
  end

  private
  
  # Use callbacks to share common setup or constraints between actions
  def set_team
    @team = Team.find(params[:id])
  end

  # Only allow a list of trusted parameters through
  def team_params
    params.require(:team).permit(:name, :description)
  end

  # Check if the current user is an admin of the team
  def authorize_team_admin!
    membership = current_user.team_memberships.find_by(team: @team)
    unless membership&.admin?
      redirect_to teams_path, alert: 'You are not authorized to perform this action.'
    end
  end
end
