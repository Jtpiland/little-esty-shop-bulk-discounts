require 'rails_helper'

RSpec.describe 'Merchant Bulk Discounts Index Page' do
  before :each do
    @merchant_1 = Merchant.create!(name: 'Sparkys Shop')

    @discount_1 = @merchant_1.bulk_discounts.create!(percentage: 20, quantity: 15)
    @discount_2 = @merchant_1.bulk_discounts.create!(percentage: 15, quantity: 10)
    @discount_3 = @merchant_1.bulk_discounts.create!(percentage: 10, quantity: 5)

    visit merchant_bulk_discounts_path(@merchant_1)
  end

  it 'can display all the merchants bulk discounts and their attributes' do
    within "#discount-#{@discount_1.id}" do
      expect(page).to have_content(@discount_1.id)
      expect(page).to have_content(@discount_1.percentage)
      expect(page).to have_content(@discount_1.quantity)
    end
    within "#discount-#{@discount_2.id}" do
      expect(page).to have_content(@discount_2.id)
      expect(page).to have_content(@discount_2.percentage)
      expect(page).to have_content(@discount_2.quantity)
    end
    within "#discount-#{@discount_1.id}" do
      expect(page).to have_content(@discount_3.id)
      expect(page).to have_content(@discount_1.percentage)
      expect(page).to have_content(@discount_1.quantity)
    end
  end

end
