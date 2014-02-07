class CreateCases < ActiveRecord::Migration
  def change
    create_table :cases do |t|
      t.string :number
      t.string :case_name
      t.integer :counselor_id
      t.integer :intake_form_id
      t.string :status,:default => "inactive"
      t.timestamps
    end
  end
end
