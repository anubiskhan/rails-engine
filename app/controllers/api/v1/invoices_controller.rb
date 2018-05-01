class Api::V1::InvoicesController < ApplicationController
  def index
    render json: Invoice.all
  end

  private

  def invoice_params
    params.require(:invoice).permit(:customer_id, :merchant_id, :status)
  end
end
