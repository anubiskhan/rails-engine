class Api::V1::InvoicesController < ApplicationController
  def index
    render json: Invoice.all
  end

  def show
    render json: Invoice.find(params[:id])
  end

  private

  def invoice_params
    params.require(:invoice).permit(:id, :customer_id, :merchant_id, :status, :created_at, :updated_at)
  end
end
