class ChangeColumnToAllowNull < ActiveRecord::Migration[5.0]
  #null制約の削除
  def change
    change_column_null :products, :brand_id, true
  end
end
