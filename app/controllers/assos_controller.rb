class AssosController < ApplicationController
  def index
   @assos = Asso.all
  end

  def show
    @asso = Asso.find(params[:id])
  end

  def new
    @asso = Asso.new
  end

  def create
    @asso = Asso.new(params[:asso])
    @asso.save

    redirect_to asso_path(@asso)
  end

  def asso_params
    params.require(:asso).permit(:name, :description, :address, :zipcode, :city, :longitude, :latitude)
  end
end
