class CreateUserAddresses < ActiveRecord::Migration[5.0]
  def change
# userモデルを作成後にuser_idカラム追加
    create_table :user_addresses do |t|
      # t.references :user, null: false, foreign_key: true
      t.integer :postal_code, null: false
      t.integer :prefecture_id, null: false
      t.string :address_city, null: false
      t.string :address_street
      t.string :address_building
      t.string :phone_number, limit: 11

      t.timestamp
    end
  end
end