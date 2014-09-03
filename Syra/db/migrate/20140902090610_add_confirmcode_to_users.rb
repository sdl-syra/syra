class AddConfirmcodeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :confirmcode, :string
  end
end
