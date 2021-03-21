class MissionsController < ApplicationController
  def index
    @missions = Mission.all
     def index
      if params[:query].present?
        sql_query = " \
        missions.title @@ :query \
        OR missions.lieu @@ :query \
        OR missions.type_mission @@ :query \
        OR missions.dispo @@ :query \
        "
        @missions = Mission.where(sql_query, query: "%#{params[:query]}%")
      else
        @missions = Mission.order("RANDOM()")
      end
    end
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
