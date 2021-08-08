class BulkDiscount < ApplicationRecord
  belongs_to :merchant
  validates :percentage, :numericality => {:only_integer => true}
  validates :quantity, :numericality => {:only_integer => true}

  #validates :percentage, presence: true, numericality: { only_integer: true, less_than_or_equal_to: 100 }
end
