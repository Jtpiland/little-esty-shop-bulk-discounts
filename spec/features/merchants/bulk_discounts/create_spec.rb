require 'rails_helper'

RSpec.describe 'Bulk Discount Creation' do
  before :each do
    @merchant_1 = Merchant.create!(name: 'Sparkys Shop')

    visit new_merchant_bulk_discount_path(@merchant_1.id)
  end

  describe 'the new bulk discount' do
    it 'renders the new form' do
      expect(page).to have_content("Create A New Discount")
      expect(find('form')).to have_content('Percentage')
      expect(find('form')).to have_content('Quantity Threshold')
    end
  end

  describe 'the bulk discount create' do
    context 'given valid data' do
      it 'creates a discount and redirects back to the merchants bulk index page' do
        percentage = 20
        quantity = 15

        fill_in 'Percentage', with: percentage
        fill_in 'Quantity Threshold', with: quantity

        click_button "Create Discount"

        expect(current_path).to eq(merchant_bulk_discounts_path(@merchant_1.id))
        expect(page).to have_content("Percentage: #{percentage}%")
        expect(page).to have_content("Quantity Threshold: #{quantity}")
        expect(BulkDiscount.first.percentage).to eq(percentage)
        expect(BulkDiscount.first.quantity).to eq(quantity)
      end
    end

    context 'given invalid data'  do
      it 're-renders the new form' do

        fill_in 'Percentage', with: 'Twenty'

        click_button "Create Discount"

        expect(current_path).to eq(new_merchant_bulk_discount_path(@merchant_1.id))
        expect(page).to have_content("Error: Field Must Be Integer")
      end
    end
  end
end
