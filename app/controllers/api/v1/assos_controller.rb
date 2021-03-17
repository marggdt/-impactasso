class Api::V1::AssosController < Api::V1::BaseController
  def index
    @assos = Asso.all
  end
end
