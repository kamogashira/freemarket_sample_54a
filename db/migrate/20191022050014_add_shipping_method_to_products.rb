class AddShippingMethodToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :shipping_method, :integer
  end
end
