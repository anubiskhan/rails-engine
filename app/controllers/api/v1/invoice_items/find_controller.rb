class Api::V1::InvoiceItems::FindController < ApplicationController
  def show
    render json: InvoiceItem.find_by(search_params)
  end

  def index
    render json: InvoiceItem.where(search_params)
  end

  private

  def search_params
    params.permit(:item_id, :invoice_id, :unit_price, :quantity, :created_at, :updated_at)
  end
end
