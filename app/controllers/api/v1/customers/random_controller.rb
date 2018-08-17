class Api::V1::Customers::RandomController < ApplicationController

  def index
    render json: Customer.find_random
  end

end
