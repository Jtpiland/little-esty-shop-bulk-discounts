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
      expect(page).to have_link(@discount_1.id)
      expect(page).to have_content(@discount_1.percentage)
      expect(page).to have_content(@discount_1.quantity)
    end
    within "#discount-#{@discount_2.id}" do
      expect(page).to have_link(@discount_2.id)
      expect(page).to have_content(@discount_2.percentage)
      expect(page).to have_content(@discount_2.quantity)
    end
    within "#discount-#{@discount_3.id}" do
      expect(page).to have_link(@discount_3.id)
      expect(page).to have_content(@discount_3.percentage)
      expect(page).to have_content(@discount_3.quantity)
    end
  end

  it 'can link to the show page of a particular bulk discount' do
    within "#discount-#{@discount_1.id}" do

      click_link "#{@discount_1.id}"

      expect(current_path).to eq(merchant_bulk_discount_path("#{@merchant_1.id}", "#{@discount_1.id}"))
    end
  end

  it 'can link to create a new discount' do
    expect(page).to have_link("Create New Discount")

    click_link "Create New Discount"

    expect(current_path).to eq(new_merchant_bulk_discount_path(@merchant_1.id))
  end

  it 'can delete a bulk discount and redirect back to merchants bulk discount index page' do
    within "#discount-#{@discount_1.id}" do
      expect(page).to have_button("Delete Bulk Discount")
        click_button "Delete Bulk Discount"
    end
    expect(page).to_not have_content(@discount_1.id)
  end
end
