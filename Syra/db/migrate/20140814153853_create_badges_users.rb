class CreateBadgesUsers < ActiveRecord::Migration
  def self.up
    create_table :badges_users, :id => false do |t|
      t.references :badge, :user
    end
  end
  def self.down
    drop_table :badges_users
  end
end
