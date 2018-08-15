class Api:V1::InvoiceItem::RandomController < ApplicationController
  def index
    render json: InvoiceItem.all.sample
  end
end
