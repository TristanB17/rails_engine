class Api::V1::Invoices::MerchantController < ApplicationController

  def index
    render json: Invoice.find(params[:id]).merchant
  end

end
