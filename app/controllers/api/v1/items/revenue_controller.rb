class Api::V1::Items::RevenueController < ApplicationController
  def index
    render json: Item.select('items.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue')
    .joins(:invoices => [:transactions, :invoice_items])
    .where(transactions: { result: "success" })
    .group(:id)
    .order('revenue DESC')
    .limit(params[:quantity])
  end
end
