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

      fill_in 'Percentage', with: 20
      fill_in 'Quantity Threshold', with: 15

      click_button 'Create Discount'

      expect(page).to have_content('Percentage: 20')
      expect(page).to have_content('Quantity Threshold: 15')
    end

    context 'given invalid data'  do

      fill_in 'Percentage', with: 'Twenty'

      expect(current_path).to eq(new_merchant_bulk_discount_path(@merchant_1.id))
      expect(page).to have_content("Error: Field Must Be Integer")
    end
  end     
end
