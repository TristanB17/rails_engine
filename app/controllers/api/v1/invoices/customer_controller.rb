class Api::V1::Invoices::CustomerController < ApplicationController

  def index
    invoice = Invoice.find(params[:id])
    render json: invoice.find_customer
  end

end
