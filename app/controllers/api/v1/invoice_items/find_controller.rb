class Api::V1::InvoiceItems::FindController < ApplicationController
  def index
    if params['id'].nil? == false
      render json: InvoiceItem.find_id(params[:id])
    elsif params['invoice_id'].nil? == false
      render json: InvoiceItem.find_invoice_id(params[:invoice_id])
    elsif params['item_id'].nil? == false
      render json: InvoiceItem.find_item_id(params[:item_id])
    elsif params['quantity'].nil? == false
      render json: InvoiceItem.find_quantity(params[:quantity])
    elsif params['unit_price'].nil? == false
      render json: InvoiceItem.find_unit_price(params[:unit_price])
    elsif params['created_at'].nil? == false
      render json: InvoiceItem.find_created_at(params[:created_at])
    else params['updated_at'].nil? == false
      render json: InvoiceItem.find_updated_at(params[:updated_at])
    end
  end
end
