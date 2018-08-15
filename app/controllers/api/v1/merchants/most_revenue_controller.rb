class Api::V1::Merchants::MostRevenueController < ApplicationController

  def index
    render json: Merchant.joins(:invoices => [:invoice_items, :transactions]).where(transactions: {result: "success"}).group(:merchant_id, :id).order("sum(quantity * unit_price) desc").limit(params[:quantity])
  end

end
