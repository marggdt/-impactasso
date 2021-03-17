class AssosController < ApplicationController
  def index
    if params[:query].present?
      sql_query = "name ILIKE :query OR description ILIKE :query"
      @assos = Asso.where(sql_query, query: "%#{params[:query]}%")
    else
      @assos = Asso.limit(10).order("RANDOM()")
    end

    # @markers = @assos.geocoded.map do |asso|
    #   {
    #     lat: asso.latitude,
    #     lng: asso.longitude,
    #     infoWindow: render_to_string(partial: "info_window", locals: { asso: asso })
    #   }
    # end
  end

  def show
    @asso = Asso.find(params[:id])
  end
end
