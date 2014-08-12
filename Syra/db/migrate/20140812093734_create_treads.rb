class CreateTreads < ActiveRecord::Migration
  def change
    create_table :treads do |t|
      t.text :subject
      t.integer :user_id
      t.integer :hobby_id

      t.timestamps
    end
  end
end
