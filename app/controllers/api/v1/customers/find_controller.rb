class Api::V1::Customers::FindController < ApplicationController

  def index
    if params['id'].nil? != true
      render json: Customer.find(params['id'])
    elsif params['first_name'].nil? != true
      render json: Customer.find_by_first_name(params['first_name'])
    elsif params['last_name'].nil? != true
      render json: Customer.find_by_last_name(params['last_name'])
    elsif params['created_at'].nil? != true
      render json: Customer.find_by_created_at(params['created_at'])
    elsif params['updated_at'].nil? != true
      render json: Customer.find_by_updated_at(params['updated_at'])
    end
  end

end
