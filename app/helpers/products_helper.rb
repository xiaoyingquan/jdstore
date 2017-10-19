module ProductsHelper

  def display_product_status(product)
    case product.status
      when "draft"
        "未上架"
      else
        ""
    end
  end
end
