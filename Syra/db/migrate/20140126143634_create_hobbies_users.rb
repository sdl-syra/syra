class CreateHobbiesUsers < ActiveRecord::Migration
   def self.up
    create_table :hobbies_users, :id => false do |t|
      t.references :hobby, :user
    end
  end
  def self.down
    drop_table :hobbies_users
  end
end
