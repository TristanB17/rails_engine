class Api::V1::Merchants::FindAllController < ApplicationController

  def index
    if params['name'].nil? != true
      render json: Merchant.find_all_name(params['name'])
    elsif params['id'].nil? != true
      render json: Merchant.find_all_id(params['id'])
    elsif params['created_at'].nil? != true
      render json: Merchant.find_all_created_at(params['created_at'])
    else
      render json: Merchant.find_all_updated_at(params['updated_at'])
    end
  end

end
