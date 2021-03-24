class AssosController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  def index
    if params[:query].present?
      # sql_query = "name ILIKE :query OR description ILIKE :query"
      # @assos = Asso.where(sql_query, query: "%#{params[:query]}%")
      @assos = Asso.left_joins(:missions)
      .select('assos.*, COUNT(missions.id) as total_mission')
      .group('assos.id')
      .search_by_all(params[:query])
      .reorder('total_mission DESC')
      .limit(20)
    else
      @assos = Asso.left_joins(:missions)
      .select('assos.*, COUNT(missions.id) as total_mission')
      .group('assos.id')
      .order('total_mission DESC')
      .limit(20)
    end

    @markers = create_map_markers(@assos)
  end

  def show
    @asso = Asso.find(params[:id])
    @marker = [{
        lat: @asso.latitude,
        lng: @asso.longitude,
      }]

     @missions_around_me = Mission.where(asso: @asso)#.where('lieu ILIKE :ville', ville: "%69%")
    #@all_missions = Mission.where(asso: @asso).where.not('lieu ILIKE :ville', ville: "%69%")
  end

  private

  def create_map_markers(assos)
    assos.map do |asso|
      {
        id: asso.id,
        lat: asso.latitude,
        lng: asso.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { asso: asso })
      }
    end
  end
end
