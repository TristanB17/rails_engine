class Api::V1::Merchants::RevenueController < ApplicationController

  def index
    unless params[:date].nil?
      render json: Merchant.find_revenue_date(params[:id], params[:date]), serializer: MerchantRevenueSerializer
    else
      render json: Merchant.find_revenue(params[:id]), serializer: MerchantRevenueSerializer
    end
  end
end
