class CreatePropositions < ActiveRecord::Migration
  def change
    create_table :propositions do |t|
      t.boolean :isPaid
      t.boolean :isAccepted
      t.boolean :motifCancelled
      t.date :proposition
      t.text :comment
      t.references :user, index: true
      t.references :service, index: true

      t.timestamps
    end
  end
end
