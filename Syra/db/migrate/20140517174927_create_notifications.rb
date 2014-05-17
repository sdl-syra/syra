class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :label
      t.string :glyph_cat
      t.string :url
      t.date :date
      t.boolean :is_checked
      t.references :user, index: true

      t.timestamps
    end
  end
end
