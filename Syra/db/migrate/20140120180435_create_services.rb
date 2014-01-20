class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :title
      t.integer :price
      t.text :description
      t.text :disponibility
      t.boolean :isGiven
      t.boolean :isFinished
      t.references :address, index: true
      t.references :category, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
