class API::V1::TransactionsController < ApplicationController
  before_action :get_account

  def index
    render json: @account.transactions.page(params[:page])
  end

  private

  def get_account
    @account ||= Account.find params[:account_id]
  end
end
