class Api::V1::Items::RandomController < ApplicationController
  def index
    render json: Item.all.sample
  end
end
