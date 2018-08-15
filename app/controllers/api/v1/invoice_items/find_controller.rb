class Api::V1::InvoiceItems::FindController < ApplicationController
  def index
    if params['id'].nil? == false
      render json: InvoiceItem.find_by(id: params[:id])
    elsif params['invoice_id'].nil? == false
      render json: InvoiceItem.find_by(invoice_id: params[:invoice_id])
    elsif params['item_id'].nil? == false
      render json: InvoiceItem.find_by(item_id: params[:item_id])
    elsif params['quantity'].nil? == false
      render json: InvoiceItem.find_by(quantity: params[:quantity])
    elsif params['unit_price'].nil? == false
      render json: InvoiceItem.find_by(unit_price: params[:unit_price])
    elsif params['created_at'].nil? == false
      render json: InvoiceItem.find_by(created_at: params([:created_at]))
    else params['updated_at'].nil? == false
      render json: InvoiceItem.find_by(updated_at: params[:updated_at])
    end
  end
end
