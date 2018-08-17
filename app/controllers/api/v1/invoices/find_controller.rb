class Api::V1::Invoices::FindController < ApplicationController
  def index
    if params['id'].nil? == false
      render json: Invoice.find_id(params[:id])
    elsif params['merchant_id'].nil? == false
      render json: Invoice.find_merchant_id(params[:merchant_id])
    elsif params['customer_id'].nil? == false
      render json: Invoice.find_customer_id(params[:customer_id])
    elsif params['status'].nil? == false
      render json: Invoice.find_status(params[:status])
    elsif params['created_at'].nil? == false
      render json: Invoice.find_created_at(params[:created_at])
    else params['updated_at'].nil? ==false
      render json: Invoice.find_updated_at(params[:updated_at])
    end
  end
end
