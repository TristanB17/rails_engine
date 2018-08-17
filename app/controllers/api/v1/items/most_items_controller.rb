class Api::V1::Items::MostItemsController < ApplicationController

  def index
    render json: Item.select('items.*, sum(invoice_items.quantity) as number_sold').joins(invoices: [:transactions]).merge(Transaction.success).group(:id).order('number_sold desc').limit(params[:quantity].to_i)
  end

end
