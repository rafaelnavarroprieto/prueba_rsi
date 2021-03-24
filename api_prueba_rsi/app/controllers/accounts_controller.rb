class AccountsController < ApplicationController
  before_action :set_accounts, only: [:show, :update, :destroy]

  def index
    @accounts = Account.all
    json_response(@accounts)
  end

  def create
    @account = Account.create!(accounts_params)
    json_response(@account, :created)
  end

  def show
    json_response(@account)
  end

  def update
    @account.update(accounts_params)
    head :no_content
  end

  def destroy
    @account.destroy
    head :no_content
  end

  private

  def accounts_params
    params.require(:account).permit(:amount, :owner, :bank_id)
  end

  def set_accounts
    @account = Bank.find(params[:id])
  end
end
