class AddBanReasonToUsers < ActiveRecord::Migration
  def change
    add_column :users, :banReason, :text
  end
end
