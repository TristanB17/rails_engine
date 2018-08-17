class Api::V1::Invoices::ItemsController < ApplicationController

  def index
    invoice = Invoice.find(params[:id])
    render json: invoice.find_items
  end

end
