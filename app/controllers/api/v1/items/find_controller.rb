class Api::V1::Items::FindController < ApplicationController
  def index
    if params['id'].nil? == false
      render json: Item.find_id(params[:id])
    elsif params['name'].nil? == false
      render json: Item.find_name(params[:name])
    elsif params['description'].nil? == false
      render json: Item.find_description(params[:description])
    elsif params['unit_price'].nil? == false
      render json: Item.find_unit_price(params[:unit_price])
    elsif params['merchant_id'].nil? == false
      render json: Item.find_merchant_id(params[:merchant_id])
    elsif params['created_at'].nil? == false
      render json: Item.find_created_at(params[:created_at])
    else params['updated_at'].nil? == false
      render json: Item.find_updated_at(params[:updated_at])
    end
  end
end
