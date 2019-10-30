class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string      :name, null: false
      t.integer     :price, null: false
      t.text        :description, null: false
      t.references  :category, null: false, foreign_key: true
      t.integer     :brand_id
      t.references  :size, foreign_key: true
      t.integer     :condition, null: false
      t.integer     :shipping_charge, null: false
      t.integer     :ship_from, null: false
      t.integer     :shipping_days, null: false
      t.integer     :shipping_method, null: false
      t.integer     :current_status, null: false
      t.references  :buyer, foreign_key: { to_table: :users }
      t.references  :seller, foreign_key: { to_table: :users }
      t.integer     :payment_method, null: false
      t.integer     :payment_status, null: false
      t.integer     :sending_status, null: false
      t.integer     :receiving_status, null: false
      t.integer     :like
      t.timestamps
    end
  end
end
