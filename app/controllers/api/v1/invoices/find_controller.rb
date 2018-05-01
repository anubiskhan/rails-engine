class Api::V1::Invoices::FindController < ApplicationController
  def show
    render json: Invoice.find_by(search_params)
  end

  private

  def search_params
    params.permit(:customer_id, :merchant_id, :status)
  end
end
