class CreateCategorySizes < ActiveRecord::Migration[5.0]
  def change
    create_table :category_sizes do |t|
      t.integer :category_id, limit: 8
      t.integer :size_id, limit: 8
      t.timestamps
    end
  end
end
