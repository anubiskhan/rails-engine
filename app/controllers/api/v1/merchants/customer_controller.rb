class Api::V1::Merchants::CustomerController < ApplicationController
  def show
    render json: Merchant.find(params[:id]).favorite_customer
  end
  def index
    render json: Merchant.find(params[:id]).customers_with_pending_invoices
  end
end
