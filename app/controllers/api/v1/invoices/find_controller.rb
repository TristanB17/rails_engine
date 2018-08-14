class FindController < ApplicationController
  def index
    if params['merchant_id'].nil? == false
      render json: Merchant.find(params[:merchant_id])
    end
  end
end
