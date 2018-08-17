class Api::V1::Merchants::RevenueController < ApplicationController

  def index
    unless params[:date].nil?
      date = Date.parse(params[:date])
      range = date.midnight..(date.midnight + 1.day)
      render json: Merchant.revenue_with_date(range, params[:id]), serializer: MerchantRevenueSerializer
    else
      render json: Merchant.revenue(params[:id]), serializer: MerchantRevenueSerializer
    end
  end
end
