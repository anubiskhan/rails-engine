class Api::V1::Merchants::RevenueController < ApplicationController
  def index
    render json: Merchant.revenue_on_date(params[:date])
  end

  def show
    if params[:date]
      render json: Merchant.find(params[:id]).revenue_on_date(params[:date])
    else
      render json: Merchant.find(params[:id]).revenue
    end
  end
end
