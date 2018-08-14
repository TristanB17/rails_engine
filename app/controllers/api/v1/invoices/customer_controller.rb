class Api::V1::Invoices::CustomerController < ApplicationController

  def index
    render json: Invoice.find(params[:id]).customer
  end

end
