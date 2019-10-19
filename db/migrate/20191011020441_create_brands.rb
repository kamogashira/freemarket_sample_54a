class CreateBrands < ActiveRecord::Migration[5.0]
  def change
    create_table :brands do |t|
      t.string :name, uniqueness: true
      t.string :ancestry, index: true

      t.timestamps
    end
  end
end
