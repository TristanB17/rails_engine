class Api::V1::Merchants::RandomController < ApplicationController

  def index
    render json: Merchant.all.sample
  end

end
