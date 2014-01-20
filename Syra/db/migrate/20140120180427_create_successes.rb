class CreateSuccesses < ActiveRecord::Migration
  def change
    create_table :successes do |t|
      t.string :label
      t.string :urlImageValidate
      t.string :urlImageUnvalidate
      t.boolean :locked
      t.references :user, index: true

      t.timestamps
    end
  end
end
