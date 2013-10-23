class TeamsController < ApplicationController
  def index
    @teams = Team.all
  end

  def new
    @team = Team.new(:event_id => params[:event_id])
  end

  def create
    @team = Team.new(team_params)
    if @team.save
      flash[:notice] = "#{@team.name} has been successfully created."
      redirect_to event_path(@team.event)
    else 
      flash[:notice] = "Something went wrong."
      render :new
    end
  end

private

  def team_params
    team.require(:team).permit(:name, :event_id)
  end
end
