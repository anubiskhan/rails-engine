class Api::V1::Invoices::RandomController < ApplicationController
  def show
    render json: Invoice.limit(1).order("RANDOM()")
  end
end
id,name,description,unit_price,merchant_id,created_at,updated_at
