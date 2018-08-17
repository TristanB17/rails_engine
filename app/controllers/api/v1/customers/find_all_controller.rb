class Api::V1::Customers::FindAllController < ApplicationController

  def index
    if params['id'].nil? != true
      render json: Customer.find_all_id(params['id'])
    elsif params['first_name'].nil? != true
      render json: Customer.find_all_first_name(params['first_name'])
    elsif params['last_name'].nil? != true
      render json: Customer.find_all_last_name(params['last_name'])
    elsif params['created_at'].nil? != true
      render json: Customer.find_all_created_at(params['created_at'])
    elsif params['updated_at'].nil? != true
      render json: Customer.find_all_updated_at(params['updated_at'])
    end
  end

end
