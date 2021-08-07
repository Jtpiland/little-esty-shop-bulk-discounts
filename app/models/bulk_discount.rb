class BulkDiscount < ApplicationRecord
  belongs_to :merchant
  validates :percentage, :numericality => {:only_integer => true}
  validates :quantity, :numericality => {:only_integer => true}

end
