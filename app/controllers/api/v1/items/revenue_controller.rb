class Api::V1::Items::RevenueController < ApplicationController
  def index
    render json: Item.revenue(params[:quantity])
  end
end
