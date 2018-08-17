class Api::V1::Merchants::DateRevenueController < ApplicationController
  def index
    date = Date.parse(params[:date])
    range = date.midnight..(date.midnight + 1.day)
    render json: Merchant.highest_revenue_date(range), serializer: AllMerchantRevenueSerializer
  end
end
