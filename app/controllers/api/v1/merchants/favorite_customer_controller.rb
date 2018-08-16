class Api::V1::Merchants::FavoriteCustomerController < ApplicationController
  def index
    render json: Merchant.select('customers.*, COUNT(invoices.id) AS favorite_customer')
    .joins(invoices: [:transactions, :customer])
    .where(transactions: { result: 'success' })
    .group('customers.id')
    .order('favorite_customer DESC')
    .find(params[:id]), serializer: FavoriteCustomerSerializer
  end
end
