class Api::V1::InvoiceItemsController < ApplicationController
  def index
    render json: InvoiceItem.all
  end

  def show
    render json: InvoiceItem.find(params[:id])
  end

  private

  def item_params
    params.require(:item).permit(:item_id, :invoice_id, :unit_price, :quantity, :created_at, :updated_at)
  end
end
