class Api::V1::Transactions::FindController < ApplicationController

  def index
    if params['id'].nil? != true
      render json: Transaction.find(params['id'])
    elsif params['invoice_id'].nil? != true
      render json: Transaction.find_by_invoice_id(params['invoice_id'])
    elsif params['credit_card_number'].nil? != true
      render json: Transaction.find_by_credit_card_number(params['credit_card_number'])
    elsif params['result'].nil? != true
      render json: Transaction.find_by_result(params['result'])
    elsif params['created_at'].nil? != true
      render json: Transaction.find_by_created_at(params['created_at'])
    elsif params['updated_at'].nil? != true
      render json: Transaction.find_by_updated_at(params['updated_at'])
    end
  end

end
