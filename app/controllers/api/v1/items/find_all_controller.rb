class Api::V1::Items::FindAllController < ApplicationController
  def index
    if params['id'].nil? == false
      render json: Item.where(id: params[:id])
    elsif params['name'].nil? == false
      render json: Item.where(name: params[:name])
    elsif params['description'].nil? == false
      render json: Item.where(description: params[:description])
    elsif params['unit_price'].nil? == false
      render json: Item.where(unit_price: params[:unit_price])
    elsif params['merchant_id'].nil? == false
      render json: Item.where(merchant_id: params[:merchant_id])
    elsif params['created_at'].nil? == false
      render json: Item.where(created_at: params([:created_at]))
    else params['updated_at'].nil? == false
      render json: Item.where(updated_at: params[:updated_at])
    end
  end
end
