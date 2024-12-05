class Api::V1::ProductsController < ApplicationController
    before_action :set_product, only: [:show, :update, :destroy]
  
    def index
      @products = Product.all.with_attached_image
      render json: @products.map { |product| product_json(product) }
    end
  
    def show
      render json: product_json(@product)
    end
  
    def create
      @product = Product.new(flat_product_params)
      if @product.save
        render json: product_json(@product), status: :created
      else
        render json: @product.errors, status: :unprocessable_entity
      end
    end
  
    def update
      if @product.update(flat_product_params)
        render json: product_json(@product)
      else
        render json: @product.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      @product.destroy
      head :no_content
    end
  
    private
  
    # Find product by ID before certain actions
    def set_product
      @product = Product.find(params[:id])
    end
  
    # Strong parameters for product
    def product_params
      params.require(:product).permit(:name, :price, :description, :image)
    end

    def flat_product_params
      params.permit(:name, :price, :description, :image)
    end
  
    # JSON structure for a product
    def product_json(product)
      {
        id: product.id,
        name: product.name,
        price: product.price,
        description: product.description,
        image_url: product.image.attached? ? url_for(product.image) : nil
      }
    end
  end
  