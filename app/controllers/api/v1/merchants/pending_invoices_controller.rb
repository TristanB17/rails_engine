class Api::V1::Merchants::PendingInvoicesController < ApplicationController
  def index
    render json: Customer.pending_invoices(params[:id])
  end
end
