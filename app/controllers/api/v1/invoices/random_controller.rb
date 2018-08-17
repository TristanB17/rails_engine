class Api::V1::Invoices::RandomController < ApplicationController
  def index
    render json: Invoice.find_random
  end
end
