class Api::V1::Merchants::RevenueController < ApplicationController

  def index
    unless params[:date].nil?
      date = Date.parse(params[:date])
      range = date.midnight..(date.midnight + 1.day)
      render json: Merchant.select("merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) AS revenue").joins(:invoices => [:invoice_items, :transactions]).where(transactions: {result: "success"}).where(invoices: {created_at: range}).group(:merchant_id, :id).find(params[:id]), serializer: MerchantRevenueSerializer
    else
      render json: Merchant.select('merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) AS revenue').joins(:invoices => [:invoice_items, :transactions]).where(transactions: {result: "success"}).group(:merchant_id, :id).find(params[:id]), serializer: MerchantRevenueSerializer
    end
  end

end
