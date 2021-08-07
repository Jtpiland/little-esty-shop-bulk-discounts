class Merchant::BulkDiscountsController < ApplicationController

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

  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    bulk_discount = BulkDiscount.new(discount_params)

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


  private

  def discount_params
    params.permit(:percentage, :quantity, :merchant_id)
  end
end
