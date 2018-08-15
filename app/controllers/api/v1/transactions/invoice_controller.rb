class Api::V1::Transactions::InvoiceController < ApplicationController
  def index
    render json: Transaction.find(params[:id]).invoice
  end
end
