class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :search]

  def home
    # render layout: 'special'
    @markers = Asso.geocoded.limit(100).map do |asso|
      {
        lat: asso.latitude,
        lng: asso.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { asso: asso })
      }
    end
  end

  def search
    redirect_to send(params[:kind] + '_path', query: params[:query])
  end
end
