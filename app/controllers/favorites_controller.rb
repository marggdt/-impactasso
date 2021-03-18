class FavoritesController < ApplicationController
  before_action :set_favorite, only: [:show, :edit, :update, :destroy]

  def profile
    @user = current_user
    @favorite_missions = current_user.favorites
    @missions = current_user.missions
  end

  def index
    @favorite = Favorite.all
  end

  def new
    @mission = mission.find(params[:mission_id])
    @favorite = favorite.new
  end

  def create
    @mission = Mission.new(params[:mission])
    @mission.save

    redirect_to root_path, notice: 'Votres mission a bien été mise en favoris'
  end

  def edit
  end

  def update
    @favorite.update(favorite_params)
    redirect_to mission_path(@favorite)
  end

  def destroy
    @favorite.destroy
    redirect_to favorites_path
  end

  private

  def favorite_params
    params.require(:favorite).permit(:user, :mission)
  end

  def set_favorite
    @favorite = favorite.find(params[:id])
  end
end
