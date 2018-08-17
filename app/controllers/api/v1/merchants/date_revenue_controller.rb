class Api::V1::Merchants::DateRevenueController < ApplicationController
  def index
    date = Date.parse(params[:date])
    range = date.midnight..(date.midnight + 1.day)
    render json: Merchant.select('SUM(invoice_items.quantity * invoice_items.unit_price) AS total_revenue')
    .joins(:invoices => [:invoice_items, :transactions])
    .merge(Transaction.success)
    .where(invoices: { created_at: range })
    .group("date_trunc('day', invoices.created_at)")
    .order('total_revenue').limit(1).take, serializer: AllMerchantRevenueSerializer
  end
end
