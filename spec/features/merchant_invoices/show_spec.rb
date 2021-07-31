require 'rails_helper'

RSpec.describe 'Invoice show page' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Sparkys Shop')

    @customer1 = Customer.create!(first_name: 'Petey', last_name: 'Wimbley')

    @item1 = @merchant1.items.create!(name: 'Teddy Bear', description: 'So fuzzy', unit_price: 2000)
    @item2 = @merchant1.items.create!(name: 'Toy Car', description: 'So fast', unit_price: 3000)
    @item3 = @merchant1.items.create!(name: 'Bouncy Ball', description: 'So bouncy', unit_price: 500)

    @invoice1 = @customer1.invoices.create!(status: 0)
    @invoice2 = @customer1.invoices.create!(status: 1)

    @transaction1 = @invoice1.transactions.create!(credit_card_number: "0123456789", credit_card_expiration_date: '12/31', result: 0)
    @transaction2 = @invoice1.transactions.create!(credit_card_number: "9876543210", credit_card_expiration_date: '01/01', result: 1)


    @invoice1.items << [@item1, @item2]
  end

  describe 'merchant' do
    it 'displays invoice attributes' do
      visit "/merchants/#{@merchant1.id}/invoices/#{@invoice1.id}"

      expect(page).to have_content(@invoice1.id)
      expect(page).to have_content(@invoice1.status)
      expect(page).to have_content(@invoice1.created_at.strftime("%A, %B %d, %Y"))
      expect(page).to have_content(@customer1.first_name)
      expect(page).to have_content(@customer1.last_name)

      expect(page).to_not have_content(@invoice2.id)
    end
  end
end
