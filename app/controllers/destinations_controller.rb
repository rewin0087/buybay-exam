class DestinationsController < ApplicationController
  before_action :fetch_product_options_meta, only: [:new, :edit, :create, :update]
  before_action :find_destination, only: [:edit, :update, :show, :destroy]

  def index
    @destinations = Destination.page(params[:page])
  end

  def routed_products
    @routed_products = Product.routed.page(params[:page])
    @unrouted_products = Product.unrouted
    @hide_action = true
  end

  def new
    @destination = Destination.new
  end

  def create
    @destination = Destination.new
    @destination.assign_attributes(destination_params)

    if @destination.valid?
      @destination.save

      redirect_to destinations_path, notice: 'Created new destination.'
    else
      render action: :new, status: :unprocessable_entity
    end
  end

  def update
    @destination.assign_attributes(destination_params)

    if @destination.valid?
      @destination.save

      redirect_to destination_path(@destination), notice: 'Destination Updated'
    else
      render action: :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @destination.destroy

    redirect_to destinations_path, notice: 'Destination Deleted'
  end

  def assign_route
    Product.find(params[:product_id]).assign_route!

    redirect_to routed_products_destinations_path, notice: 'Products were routed.'
  end

  private

    def destination_params
      params.require(:destination).permit(:name, :maximum_price, references: [], categories: [])
    end

    def find_destination
      @destination = Destination.find(params[:id])
    end

    def fetch_product_options_meta
      @product_categories = Product.categories
      @product_references = Product.references
    end
end
