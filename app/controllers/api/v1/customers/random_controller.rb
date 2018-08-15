class Api::V1::Customers::RandomController < ApplicationController

  def index
    render json: Customer.all.sample
  end

end
