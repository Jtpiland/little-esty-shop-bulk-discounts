class Merchant::BulkDiscountsController < ApplicationController
  before_action :holiday_fetch

  def holiday_fetch
    json = NagerService.new.holiday
    @holidays = json[0..2].map do |holiday|
      Holiday.new(holiday)
    end
  end

  def index
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discounts = BulkDiscount.all
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = BulkDiscount.new
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    bulk_discount = @merchant.bulk_discounts.create(discount_params)
    if bulk_discount.save
      redirect_to merchant_bulk_discounts_path(@merchant.id)
    else
      redirect_to new_merchant_bulk_discount_path(@merchant.id)
      flash[:alert] = "Error: Field Must Be Integer"
    end
  end

  def destroy
    @merchant = Merchant.find(params[:merchant_id])
    bulk_discount = BulkDiscount.find(params[:id])

    bulk_discount.destroy
    redirect_to merchant_bulk_discounts_path(@merchant.id)
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:merchant_id])
    bulk_discount = BulkDiscount.find(params[:id])
    bulk_discount.update(discount_params)
    redirect_to merchant_bulk_discount_path(merchant, bulk_discount)
    flash[:alert] = "Your Discount Has Been Changed"
  end

  private

  def discount_params
    params.require(:bulk_discount).permit(:percentage, :quantity, :merchant_id)
  end
end
