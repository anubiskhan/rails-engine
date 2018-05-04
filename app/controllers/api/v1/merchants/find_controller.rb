class Api::V1::Merchants::FindController < ApplicationController
  def show
    render json: Merchant.find_by(search_params)
  end

  def index
    render json: Merchant.where(search_params)
  end

  private

    def search_params
      params.permit(:id, :name, :updated_at, :created_at)
    end
end
