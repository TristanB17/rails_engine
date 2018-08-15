class Api::V1::Merchants::RevenueController < ApplicationController

  def index
    render json: Merchant.select('merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) AS revenue').joins(:invoices => [:invoice_items, :transactions]).where(transactions: {result: "success"}).group(:merchant_id, :id).find(params[:id]), serializer: MerchantRevenueSerializer
  end

end
