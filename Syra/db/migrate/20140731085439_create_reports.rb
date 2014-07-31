class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.string :category
      t.text :content
      t.integer :service_id

      t.timestamps
    end
  end
end
