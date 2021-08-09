require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe 'relationships' do
    it {should belong_to :item}
    it {should belong_to :invoice}
  end

  describe 'validations' do
    it {should define_enum_for(:status).with_values([:pending, :packaged, :shipped])}
  end

  describe 'instance methods' do
    it 'can transform unit price to dollars' do
      merchant1 = Merchant.create!(name: 'Sparkys Shop')
      item = merchant1.items.create!(name: 'Teddy Bear', description: 'So fuzzy', unit_price: 2050)
      customer = Customer.create!(first_name: 'Sally', last_name: 'Sal')
      invoice = Invoice.create!(customer_id: customer.id, status: 0)
      ii = InvoiceItem.create!(item_id: item.id, invoice_id: invoice.id, status: 1, unit_price: 2080, quantity: 1)

      expect(ii.price_to_dollars(item.unit_price)).to eq(20.50)
      expect(ii.price_to_dollars(ii.unit_price)).to eq(20.80)
    end

    it 'can manipulate price to dollars without argument' do
      merchant_1 = Merchant.create!(name: 'The Wand Shop')
      item = merchant_1.items.create!(name: 'Horse Feather Oak', description: 'So magical', unit_price: 20000)
      customer = Customer.create!(first_name: 'Harry', last_name: 'Potter')
      invoice = Invoice.create!(customer_id: customer.id, status: 0)
      ii = InvoiceItem.create!(item_id: item.id, invoice_id: invoice.id, status: 1, unit_price: 20000, quantity: 1)

      expect(ii.unit_price_to_dollars).to eq(200.00)
    end

    it 'can find the total revenue for the invoice item in cents' do
      merchant_1 = Merchant.create!(name: 'The Wand Shop')
      discount_1 = merchant_1.bulk_discounts.create!(percentage: 10, quantity: 5)
      discount_1 = merchant_1.bulk_discounts.create!(percentage: 20, quantity: 10)
      item = merchant_1.items.create!(name: 'Horse Feather Oak', description: 'So magical', unit_price: 20000)
      customer = Customer.create!(first_name: 'Harry', last_name: 'Potter')
      invoice = Invoice.create!(customer_id: customer.id, status: 0)
      ii = InvoiceItem.create!(item_id: item.id, invoice_id: invoice.id, status: 1, unit_price: 20000, quantity: 10)

      expect(ii.total_ii_revenue).to eq(200000)
    end

    it 'can find the maximum discount for an invoice item' do
      merchant_1 = Merchant.create!(name: 'The Wand Shop')
      discount_1 = merchant_1.bulk_discounts.create!(percentage: 10, quantity: 5)
      discount_1 = merchant_1.bulk_discounts.create!(percentage: 20, quantity: 10)
      item = merchant_1.items.create!(name: 'Horse Feather Oak', description: 'So magical', unit_price: 20000)
      customer = Customer.create!(first_name: 'Harry', last_name: 'Potter')
      invoice = Invoice.create!(customer_id: customer.id, status: 0)
      ii = InvoiceItem.create!(item_id: item.id, invoice_id: invoice.id, status: 1, unit_price: 20000, quantity: 10)

      expect(ii.find_discount).to eq(20)
    end

    it 'can find the total discounted revenue' do
      merchant_1 = Merchant.create!(name: 'The Wand Shop')
      discount_1 = merchant_1.bulk_discounts.create!(percentage: 10, quantity: 5)
      discount_1 = merchant_1.bulk_discounts.create!(percentage: 20, quantity: 10)
      item = merchant_1.items.create!(name: 'Horse Feather Oak', description: 'So magical', unit_price: 20000)
      customer = Customer.create!(first_name: 'Harry', last_name: 'Potter')
      invoice = Invoice.create!(customer_id: customer.id, status: 0)
      ii = InvoiceItem.create!(item_id: item.id, invoice_id: invoice.id, status: 1, unit_price: 20000, quantity: 10)

      expect(ii.discounted_ii_revenue).to eq(1600)
    end
  end
end
