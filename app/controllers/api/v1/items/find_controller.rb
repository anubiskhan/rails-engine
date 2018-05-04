class Api::V1::Items::FindController < ApplicationController
  def show
    if params[:unit_price]
      render json: Item.find_by(unit_price: (params[:unit_price].delete('.')))
    else
      render json: Item.find_by(search_params)
    end
  end

  def index
    if params[:unit_price]
      render json: Item.where(unit_price: (params[:unit_price].delete('.')))
    else
      render json: Item.where(search_params)
    end
  end

  private

  def search_params
    params.permit(:id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at)
  end
end
