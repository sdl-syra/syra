class AddGuiltyToReport < ActiveRecord::Migration
  def change
    add_column :reports, :guilty, :boolean
  end
end
