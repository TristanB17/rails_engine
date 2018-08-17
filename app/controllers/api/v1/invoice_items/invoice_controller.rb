class Api::V1::InvoiceItems::InvoiceController < ApplicationController
  def index
    invoice_item = InvoiceItem.find(params[:id])
    render json: invoice_item.find_invoice
  end
end
