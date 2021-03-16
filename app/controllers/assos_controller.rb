class AssosController < ApplicationController

  def index
  	@assos = Asso.all
  end

  def show
    @asso = Asso.find(params[:id])
  end

end
