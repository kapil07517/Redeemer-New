class CreateIntakeForms < ActiveRecord::Migration
  def change
    create_table :intake_forms do |t|
      t.integer :user_id
      t.string :intake_type
      t.string :intake_status
      t.integer :case_id
      t.timestamps
    end
  end
end
