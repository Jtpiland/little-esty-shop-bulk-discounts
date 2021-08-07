require 'rails_helper'

RSpec.describe 'Merchants Bulk Discount Edit Page' do
  before :each do
    @merchant_1 = Merchant.create!(name: 'Sparkys Shop')

    @discount_1 = @merchant_1.bulk_discounts.create!(percentage: 20, quantity: 15)

    visit edit_merchant_bulk_discount_path(@merchant_1, @discount_1)
  end

  it 'has the discount attribute fields pre-populated' do
    percentage = 20
    quantity = 15

    expect(page).to have_field('Percentage', with: percentage)
    expect(page).to have_field('Quantity', with: quantity)
  end

  it 'can edit and submit the updated discount then redirect back to the show page' do
    percentage = 15
    quantity = 10

    fill_in 'Percentage', with: percentage
    fill_in 'Quantity', with: quantity

    click_button "Update Discount"

    expect(current_path).to eq(merchant_bulk_discount_path(@merchant_1, @discount_1))
    expect(page).to have_content(percentage)
    expect(page).to have_content(quantity)
  end
end
