class MissionsController < ApplicationController
  def index
    @missions = Mission.all
  end

  def show
    @mission = Mission.find(params[:id])
  end

  def new
    @mission = Mission.new
  end

  def create
    @mission = Mission.new(params[:mission])
    @mission.save

    redirect_to mission_path(@mission)
  end

  private

  def mission_params
    params.require(:mission).permit(:name, :address, :description, :longitude, :latitude)
  end
end
