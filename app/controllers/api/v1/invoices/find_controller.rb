class Api::V1::Invoices::FindController < ApplicationController
  def index
    if params['id'].nil? == false
      render json: Invoice.find_by(id: params[:id])
    elsif params['merchant_id'].nil? == false
      render json: Invoice.find_by(merchant_id: params[:merchant_id])
    elsif params['customer_id'].nil? == false
      render json: Invoice.find_by(customer_id: params[:customer_id])
    elsif params['status'].nil? == false
      render json: Invoice.find_by(status: params[:status])
    elsif params['created_at'].nil? == false
      render json: Invoice.find_by(created_at: params[:created_at])
    else params['updated_at'].nil? ==false
      render json: Invoice.find_by(updated_at: params[:updated_at])
    end
  end
end
