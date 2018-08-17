class Api::V1::Merchants::RandomController < ApplicationController

  def index
    render json: Merchant.find_random
  end

end
