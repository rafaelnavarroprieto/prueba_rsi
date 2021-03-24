class Account < ApplicationRecord

  has_many :transactions
  belongs_to :bank

  validates :amount, presence: true
  validates :owner, presence: true  

  before_create :set_isbn

  def set_isbn
    self.isbn = "#{self.bank.entity_id}#{rand(1000..9999)}".to_i
  end
end
