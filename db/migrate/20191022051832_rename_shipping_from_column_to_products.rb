class RenameShippingFromColumnToProducts < ActiveRecord::Migration[5.0]
  def change
    rename_column :products, :shipping_from, :ship_from
  end
end
