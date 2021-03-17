class AssosController < ApplicationController
  def index
    if params[:query].present?
      sql_query = "name ILIKE :query OR description ILIKE :query"
      @assos = Asso.where(sql_query, query: "%#{params[:query]}%")
    else
      @assos = Asso.limit(10).order("RANDOM()")
    end
  end

  def show
    @asso = Asso.find(params[:id])
  end
end
