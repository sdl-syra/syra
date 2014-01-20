class CreateLevels < ActiveRecord::Migration
  def change
    create_table :levels do |t|
      t.integer :levelUser
      t.integer :XPUser
      t.references :user, index: true

      t.timestamps
    end
  end
end
