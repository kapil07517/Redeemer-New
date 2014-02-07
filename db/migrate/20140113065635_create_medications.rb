class CreateMedications < ActiveRecord::Migration
  def change
    create_table :medications do |t|
      t.integer :medical_id
      t.string :medician
      t.string :dosage
      t.timestamps
    end
  end
end
