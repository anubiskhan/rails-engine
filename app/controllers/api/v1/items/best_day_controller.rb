class Api::V1::Items::BestDayController < ApplicationController
  def show
    date = Item.find(params[:id]).best_day
    render json: { 'best_day' => date }
  end
end
