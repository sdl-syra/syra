class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :lastName
      t.string :email
      t.string :money
      t.string :password
      t.string :phone
      t.text :biography
      t.boolean :isPremium
      t.references :level, index: true
      t.references :success, index: true
      t.references :address, index: true
      t.datetime :birthday
      t.timestamps
    end
  end
end
