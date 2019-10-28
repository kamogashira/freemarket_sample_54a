class ChangeDataColumnsToProducts < ActiveRecord::Migration[5.0]
  def change
    change_column :products, :condition, :integer
    change_column :products, :shipping_charge, :integer
    change_column :products, :ship_from, :integer
    change_column :products, :shipping_days, :integer
  end
end
