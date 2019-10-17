class RenameBrandColumnToProducts < ActiveRecord::Migration[5.0]
  def change
    rename_column :products, :brand, :brand_id
  end
end
