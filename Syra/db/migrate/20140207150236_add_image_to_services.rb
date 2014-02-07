class AddImageToServices < ActiveRecord::Migration
  def change
    add_column :services, :image, :String
  end
end
