class Api::V1::Transactions::RandomController < ApplicationController

  def index
    render json: Transaction.find_random
  end

end
