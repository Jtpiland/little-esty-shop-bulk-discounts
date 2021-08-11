class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice

  enum status: [:pending, :packaged, :shipped]


  def unit_price_to_dollars
    self.unit_price / 100.00
  end

  def price_to_dollars(unit_price)
    (unit_price / 100.00).round(2)
  end

  def total_ii_revenue
    unit_price * quantity / 100
  end

  def find_discount
    item.merchant.bulk_discounts
    .where('quantity <= ?', quantity)
    .order(percentage: :desc)
    .first
  end

  def discounted_ii_revenue
    if find_discount.blank?
      total_ii_revenue
    else
      (total_ii_revenue - (total_ii_revenue * (find_discount.percentage.to_f/100)))
    end
  end
end
