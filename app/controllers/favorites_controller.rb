class FavoritesController < ApplicationController
  def toggle_favorite
    @mission = Mission.find(params[:mission_id])
    is_favori = Favorite.where(user: current_user, mission: @mission)&.first
    if is_favori
      is_favori.destroy
    else
      Favorite.create(mission: @mission, user: current_user)
    end
    if params[:from] == 'user_profile'
      redirect_to user_path(current_user)
    else
      redirect_to missions_path(query: params[:query])
    end
  end
end
