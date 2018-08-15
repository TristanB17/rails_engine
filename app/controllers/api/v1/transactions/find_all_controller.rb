class Api::V1::Transactions::FindAllController < ApplicationController

  def index
    if params['id'].nil? != true
      render json: Transaction.where(id: params['id'])
    elsif params['invoice_id'].nil? != true
      render json: Transaction.where(invoice_id: (params['invoice_id']))
    elsif params['credit_card_number'].nil? != true
      render json: Transaction.where(credit_card_number: (params['credit_card_number']))
    elsif params['result'].nil? != true
      render json: Transaction.where(result: (params['result']))
    elsif params['created_at'].nil? != true
      render json: Transaction.where(created_at:(params['created_at']))
    elsif params['updated_at'].nil? != true
      render json: Transaction.where(updated_at:(params['updated_at']))
    end
  end

end
