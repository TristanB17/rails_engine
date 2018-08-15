class Api::V1::Customers::FindAllController < ApplicationController

  def index
    if params['id'].nil? != true
      render json: Customer.where(id: params['id'])
    elsif params['first_name'].nil? != true
      render json: Customer.where(first_name: (params['first_name']))
    elsif params['last_name'].nil? != true
      render json: Customer.where(last_name: (params['last_name']))
    elsif params['created_at'].nil? != true
      render json: Customer.where(created_at:(params['created_at']))
    elsif params['updated_at'].nil? != true
      render json: Customer.where(updated_at:(params['updated_at']))
    end
  end

end
