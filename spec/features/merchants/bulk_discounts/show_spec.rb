require 'rails_helper'

RSpec.describe 'Bulk Discount Shwo Page' do
  before :each do
    @merchant_1 = Merchant.create!(name: 'Sparkys Shop')

    @discount_1 = @merchant_1.bulk_discounts.create!(percentage: 20, quantity: 15)
    @discount_2 = @merchant_1.bulk_discounts.create!(percentage: 15, quantity: 10)

    visit merchant_bulk_discount_path(@merchant_1, @discount_1)
  end

  it 'can display the attributes of a particular discount' do
    expect(page).to have_content(@discount_1.id)
    expect(page).to have_content(@discount_1.percentage)
    expect(page).to have_content(@discount_1.quantity)
    expect(page).to_not have_content(@discount_2.id)
  end

  it 'can link to new page with form to edit bulk discount' do
    expect(page).to have_link("Edit Discount: #{@discount_1.id}")

    click_link "Edit Discount: #{@discount_1.id}"

    expect(current_path).to eq(edit_merchant_bulk_discount_path(@merchant_1, @discount_1))
  end
end
