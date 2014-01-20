class CreateEvaluations < ActiveRecord::Migration
  def change
    create_table :evaluations do |t|
      t.integer :note
      t.text :comment
      t.references :proposition, index: true

      t.timestamps
    end
  end
end
