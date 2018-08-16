class Api::V1::Merchants::PendingInvoicesController < ApplicationController
  def index
    render json: Customer.where(id: (Invoice.where(id: Transaction.joins(:invoice)
    .where(result: 'failed').pluck(:invoice_id))
    .where.not(id: Transaction.joins(:invoice)
    .where(result: 'success')
    .pluck(:invoice_id))
    .where(merchant_id: params[:id])
    .pluck(:customer_id)))
  end
end
