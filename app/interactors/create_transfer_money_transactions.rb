class CreateTransferMoneyTransactions
  include Interactor

  def call
    ActiveRecord::Base.transaction do
      outbound_trans = context.sender.transactions.create(amount: context.amount * (-1), transaction_type: :outbound)
      inbound_trans = context.receiver.transactions.create(amount: context.amount, transaction_type: :inbound, reference: outbound_trans)
      outbound_trans.update(reference: inbound_trans)
    end
  end
end
