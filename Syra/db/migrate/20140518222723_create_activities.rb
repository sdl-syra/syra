class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.references :user, index: true
      t.string :label
      t.string :glyph_cat
      t.date :date

      t.timestamps
    end
  end
end
