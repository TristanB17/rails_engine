class Api::V1::Invoices::MerchantController < ApplicationController

  def index
    invoice = Invoice.find(params[:id])
    render json: invoice.find_merchant
  end

end
