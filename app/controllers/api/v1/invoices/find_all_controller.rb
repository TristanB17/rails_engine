class Api::V1::Invoices::FindAllController < ApplicationController
  def index
    if params['id'].nil? == false
      render json: Invoice.where(id: params[:id])
    elsif params['merchant_id'].nil? == false
      render json: Invoice.where(merchant_id: params[:merchant_id])
    elsif params['customer_id'].nil? == false
      render json: Invoice.where(customer_id: params[:customer_id])
    elsif params['status'].nil? == false
      render json: Invoice.where(status: params[:status])
    elsif params['created_at'].nil? == false
      render json: Invoice.where(created_at: params[:created_at])
    else params['updated_at'].nil? ==false
      render json: Invoice.where(updated_at: params[:updated_at])
    end
  end
end
