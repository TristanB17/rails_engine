class Api::V1::Items::RandomController < ApplicationController
  def index
    render json: Item.find_random
  end
end
