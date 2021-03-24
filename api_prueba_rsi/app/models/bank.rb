class Bank < ApplicationRecord

  has_many :accounts

  validates :name, presence: true
  validates :entity_id, presence: true, numericality: { only_integer: true }


end