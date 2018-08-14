class Api::V1::Merchants::FindAllController < ApplicationController

  def index
    if params['name'].nil? != true
      render json: Merchant.where(name:params['name'])
    elsif params['id'].nil? != true
      render json: Merchant.where(id:params['id'])
    elsif params['created_at'].nil? != true
      render json: Merchant.where(created_at:params['created_at'])
    else
      render json: Merchant.where(updated_at:params['updated_at'])
    end
  end

end
