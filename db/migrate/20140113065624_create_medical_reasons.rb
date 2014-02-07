class CreateMedicalReasons < ActiveRecord::Migration
  def change
    create_table :medical_reasons do |t|
      t.integer :medical_id
      t.string :previous_hospital
      t.date :previous_hospital_date
      t.timestamps
    end
  end
end
