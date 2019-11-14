class CreateDeliveryAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :delivery_addresses do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :first_name_kana, null: false
      t.string :last_name_kana, null: false
      t.integer :postal_code, null: false
      t.integer :prefecture_id, null: false
      t.string :address_city, null: false
      t.string :address_street, null: false
      t.string :address_building
      t.string :phone_number, limit: 11
      t.integer :user_id, null: false
      t.timestamps
    end
  end
end
