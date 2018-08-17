class Api::V1::InvoiceItems::FindAllController < ApplicationController
  def index
    if params['id'].nil? == false
      render json: InvoiceItem.find_all_id(params[:id])
    elsif params['invoice_id'].nil? == false
      render json: InvoiceItem.find_all_invoice_id(params[:invoice_id])
    elsif params['item_id'].nil? == false
      render json: InvoiceItem.find_all_item_id(params[:item_id])
    elsif params['quantity'].nil? == false
      render json: InvoiceItem.find_all_quantity(params[:quantity])
    elsif params['unit_price'].nil? == false
      render json: InvoiceItem.find_all_unit_price(params[:unit_price])
    elsif params['created_at'].nil? == false
      render json: InvoiceItem.find_all_created_at(params[:created_at])
    else params['updated_at'].nil? == false
      render json: InvoiceItem.find_all_updated_at(params[:updated_at])
    end
  end
end
