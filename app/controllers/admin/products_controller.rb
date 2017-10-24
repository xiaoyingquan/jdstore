class Admin::ProductsController < ApplicationController

  layout "admin"

  before_action :authenticate_user!
  before_action :admin_required

  def index
    @products = Product.rank(:row_order).all
  end

  def new
    @product = Product.new
    @categories = Category.all.map { |c| [c.name, c.id] }
  end

  def show
    @product = Product.find_by_friendly_id!(params[:id])
  end

  def edit
    @product = Product.find_by_friendly_id!(params[:id])
    @categories = Category.all.map { |c| [c.name, c.id] }
  end

  def update
    @product = Product.find_by_friendly_id!(params[:id])
    @product.category_id = params[:category_id]

    if @product.update(product_params)
      redirect_to admin_products_path
    else
      render :edit
    end
  end

  def create
    @product = Product.new(product_params)
    @product.category_id = params[:category_id]

    if @product.save
      redirect_to admin_products_path
    else
      render :new
    end
  end

  def destroy
    @product = Product.find_by_friendly_id!(params[:id])

    @product.destroy
    radiract_to admin_paroducts_path, alert:'Product deleted'
  end

  def bulk_update
    total = 0
    Array(params[:ids]).each do |product_id|
      product = Product.find(product_id)
      if params[:commit] == I18n.t(:bulk_update)
        product.status = params[:product_status]
        if product.save
          total += 1
        end
      elsif params[:commit] == I18n.t(:bulk_delete)
        product.destroy
        total += 1
      end
    end

    flash[:alert] = "成功完成 #{total} 笔"
    redirect_to admin_products_path
  end

  def reorder
    @product = Product.find_by_friendly_id!(params[:id])
    @product.row_order_position = params[:position]
    @product.save!

    redirect_to admin_products_path
  end

private

  def product_params
    params.require(:product).permit(:title, :description, :quantity, :price, :image, :friendly_id, :status, :category_ids => [])
  end
end
