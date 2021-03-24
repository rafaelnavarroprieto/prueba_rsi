class Transaction < ApplicationRecord

  COMMISSION = 5

  belongs_to :account_sender, class_name: "Account" , foreign_key: :account_sender_id
  belongs_to :account_received, class_name: "Account" , foreign_key: :account_received_id

  validates :transaction_type, presence: true, inclusion: { in: [1, 2] }
  validates :amount, presence: true, numericality: { less_than_or_equal_to: 1000 }, unless: :same_accounts_bank?

  before_create :set_type_finished_flag
  after_create :do_transaction
  
  scope :total_amount_by_account, -> (account_id) { where(account_sender: account_id).sum(&:amount) }
  scope :failure_transactions, -> (account_id) { where(finished: false) }

  def set_type_finished_flag
    self.same_accounts_bank? ? self.transaction_type = 1 : self.transaction_type = 2
    self.finished = false
  end

  def same_accounts_bank?
    return true if account_sender.bank.id == account_received.bank.id
  end

  def do_transaction
    if same_accounts_bank?
      apply_transaction_changes(account_sender.id, account_received.id, amount)
    else
      if [1,2,3].include? rand(1..10) #simulate 30% prob
        self.finished = false
      else
        apply_transaction_changes(account_sender.id, account_received.id, amount)
      end
    end
  end

  def apply_transaction_changes(sender_id, receiver_id, amount)
    sender = Account.find(sender_id)
    receiver = Account.find(receiver_id)
    sender.update(amount: sender.amount - amount_recalculated)
    receiver.update(amount: receiver.amount + amount)
    self.update(finished: true)
  end

  def amount_recalculated
    if self.transaction_type == 2
      (amount + COMMISSION)
    else
      amount
    end
  end
end
