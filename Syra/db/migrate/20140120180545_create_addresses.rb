class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.integer :number
      t.string :street
      t.string :postalCode
      t.string :town
      t.float :x
      t.float :y

      t.timestamps
    end
  end
end
