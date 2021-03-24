class TransactionsController < ApplicationController
  before_action :set_transactions, only: [:show, :update, :destroy]

  def index
    @transactions = Transaction.all
    json_response(@transactions)
  end

  def create
    @transaction = Transaction.create!(transactions_params)
    json_response(@transaction, :created)
  end

  def show
    json_response(@transaction)
  end

  def update
    @transaction.update(transactions_params)
    head :no_content
  end

  def destroy
    @transaction.destroy
    head :no_content
  end

  private

  def transactions_params
    params.permit(:account_sender_id, :account_received_id, :amount)
  end

  def set_transactions
    @transaction = Transaction.find(params[:id])
  end
end
