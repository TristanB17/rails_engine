class Api::V1::Merchants::FindController < ApplicationController

  def index
    if params['name'].nil? != true
      render json: Merchant.find_by_name(params['name'])
    elsif params['id'].nil? != true
      render json: Merchant.find(params['id'])
    elsif params['created_at'].nil? != true
      render json: Merchant.find_by_created_at(params['created_at'])
    else
      render json: Merchant.find_by_updated_at(params['updated_at'])
    end
  end

end
