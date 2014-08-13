class CreateOpinions < ActiveRecord::Migration
  def change
    create_table :opinions do |t|
      t.text :avis
      t.integer :note
      t.references :service, index: true

      t.timestamps
    end
  end
end
