class RemoveThreadIdToReplies < ActiveRecord::Migration
  def change
    remove_column :replies, :thread_id, :integer
  end
end
