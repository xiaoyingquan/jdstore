class ProductsController < ApplicationController
  def index
    @products = Product.rank(:row_order).all
  end

  def show
    @product = Product.find_by_friendly_id!(params[:id])
  end

  def add_to_cart
    @product = Product.find(params[:id])
    if !current_cart.products.include?(@product)
      current_cart.add_product_to_cart(@product)
      flash[:notice] = "你已成功将 #{@product.title} 加入购物车"
    else
      flash[:warning] = "你的购物车内已有此物品"
    end
  end
end
