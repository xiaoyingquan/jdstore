class AddRowOrderToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :row_order, :integer

    # 因为要改用这个 row_order 来做排序，而数据库已经有的 products 默认时 nil
    # 因此这里要设定 row_order 的值，其中 `:last` 是 ranked-model
    Product.find_each do |p|
      p.update( :row_order_position => :last )
    end

    add_index :products, :row_order
  end
end
