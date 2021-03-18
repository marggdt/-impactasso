class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @markers = Asso.geocoded.limit(100).map do |asso|
      {
        lat: asso.latitude,
        lng: asso.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { asso: asso })
      }
    end
  end
end
