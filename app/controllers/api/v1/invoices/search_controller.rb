class Api::V1::Invoices::SearchController < ApplicationController
  def index
    if params['merchant_id'].nil? == false
      render json: Invoice.find(params[:merchant_id])
    elsif params['customer_id'].nil? == false
      render json: Invoice.find(params[:customer_id])
    elsif params['status'].nil? == false
      render json: Invoice.find(params[:status])
    elsif params['created_at'].nil? == false
      render json: Invoice.find(params[:created_at])
    else params['updated_at'].nil? ==false
      render json: Invoice.find(params[:updated_at])
    end
  end
end
