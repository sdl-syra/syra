class AddPrivateToServices < ActiveRecord::Migration
  def change
    add_column :services, :private, :boolean
  end
end
