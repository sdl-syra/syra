class CreateBadges < ActiveRecord::Migration
  def change
    create_table :badges do |t|
      t.string :label

      t.timestamps
    end
  end
end
