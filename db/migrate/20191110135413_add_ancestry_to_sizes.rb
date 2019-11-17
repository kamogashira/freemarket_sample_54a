class AddAncestryToSizes < ActiveRecord::Migration[5.0]
  def change
    add_column :sizes, :ancestry, :string
  end
end
