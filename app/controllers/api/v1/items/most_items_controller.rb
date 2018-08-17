class Api::V1::Items::MostItemsController < ApplicationController
  def index
    render json: Item.most_items_by_quantity(params[:quantity])
  end
end
