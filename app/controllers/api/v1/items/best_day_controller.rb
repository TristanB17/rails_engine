class Api::V1::Items::BestDayController < ApplicationController

  def index
    render json: Item.find(params[:id]).invoices.select('sum(invoice_items.quantity) as sale_count, invoices.created_at as best_day').joins(:transactions, :invoice_items).where(transactions: {result: 'success'}).group('invoices.created_at').order('sale_count desc').limit(1).take, serializer: ItemBestDaySerializer
  end

end
