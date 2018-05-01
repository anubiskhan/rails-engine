class Api::V1::Merchants::FindController < ApplicationController
  def show
    render json: Merchant.find_by(search_params)
  end

  private

    def search_params
      params.permit(:id, :name)
    end
end
