class BanksController < ApplicationController
  before_action :set_banks, only: [:show, :update, :destroy]

  def index
    @banks = Bank.all
    json_response(@banks)
  end

  def create
    @bank = Bank.create!(banks_params)
    json_response(@bank, :created)
  end

  def show
    json_response(@bank)
  end

  def update
    @bank.update(banks_params)
    head :no_content
  end

  def destroy
    @bank.destroy
    head :no_content
  end

  private

  def banks_params
    params.permit(:name, :entity_id)
  end

  def set_banks
    @bank = Bank.find(params[:id])
  end
end
