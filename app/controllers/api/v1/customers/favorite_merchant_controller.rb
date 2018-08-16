class Api::V1::Customers::FavoriteMerchantController < ApplicationController

  def index
    render json: Merchant.select('merchants.*, count(invoices.id) as invoice_count').joins(:invoices => :transactions).where(transactions: {result: 'success'}).where(invoices: {customer_id: params[:id]}).group(:id).order('invoice_count desc').limit(1).take
  end

end
