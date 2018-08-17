class Api:V1::InvoiceItem::RandomController < ApplicationController
  def index
    render json: InvoiceItem.find_random
  end
end
