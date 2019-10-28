class CreateEvaluations < ActiveRecord::Migration[5.0]
  def change
    create_table :evaluations do |t|
      t.references :user, foreign_key: true
      t.references :product, foreign_key: true
      t.integer :good
      t.integer :normal
      t.integer :bad
      t.string :comment

      t.timestamps
    end
  end
end
