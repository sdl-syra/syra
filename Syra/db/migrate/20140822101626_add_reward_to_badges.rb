class AddRewardToBadges < ActiveRecord::Migration
  def change
    add_column :badges, :reward, :integer
  end
end
