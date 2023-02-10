class ProductsController < ApplicationController
  before_action :find_product, only: [:edit, :update, :show, :destroy]

  def index
    @products = Product.page(params[:page])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.valid?
      @product.save

      redirect_to products_path, notice: 'Product Created'
    else
      render action: :new, status: :unprocessable_entity
    end
  end

  def update
    @product.assign_attributes(product_params)

    if @product.valid?
      @product.save

      redirect_to product_path(@product), notice: 'Product Updated'
    else
      render action: :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy

    redirect_to products_path, notice: 'Product Deleted'
  end

  private

    def find_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :price, :reference, :category)
    end
end
