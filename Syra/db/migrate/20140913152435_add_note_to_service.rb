class AddNoteToService < ActiveRecord::Migration
  def change
    add_column :services, :note, :float
  end
end
