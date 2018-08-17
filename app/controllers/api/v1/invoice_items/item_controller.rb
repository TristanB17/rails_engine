class Api::V1::InvoiceItems::ItemController < ApplicationController
  def index
    invoice_item = InvoiceItem.find(params[:id])
    render json: invoice_item.find_item
  end
end
