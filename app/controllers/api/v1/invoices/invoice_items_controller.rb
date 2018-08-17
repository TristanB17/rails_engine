class Api::V1::Invoices::InvoiceItemsController < ApplicationController

  def index
    invoice = Invoice.find(params[:id])
    render json: invoice.find_invoice_items
  end

end
