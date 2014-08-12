class AddTreadIdToReplies < ActiveRecord::Migration
  def change
    add_column :replies, :tread_id, :integer
  end
end
