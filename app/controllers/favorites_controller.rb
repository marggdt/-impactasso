class FavoritesController < ApplicationController
  def index
    @favorites = Favorite.all
  end

  def toggle_favorite
    @mission = Mission.find(params[:mission_id])
    is_favori = Favorite.where(user: current_user, mission: @mission)&.first
    if is_favori
      is_favori.destroy
    else
      Favorite.create(mission: @mission, user: current_user)
    end
    if params[:from] == 'user_favorites'
      redirect_to favorites_path
    elsif params[:from] == 'mission_show'
      redirect_to mission_path(@mission)
    elsif params[:from] == 'asso_show'
      redirect_to asso_path(@mission.asso)
    else
      redirect_to missions_path(query: params[:query])
    end
  end
end
