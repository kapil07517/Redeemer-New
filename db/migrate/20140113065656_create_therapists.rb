class CreateTherapists < ActiveRecord::Migration
  def change
    create_table :therapists do |t|
      t.integer :medical_id
      t.string :full_name
      t.string :location
      t.date :therapy_date
      t.timestamps
    end
  end
end
