class Api::V1::Invoices::RandomController < ApplicationController
  def index
    render json: Invoice.all.sample
  end
end
