class CreateCaseIntakeForms < ActiveRecord::Migration
  def change
    create_table :case_intake_forms do |t|
      t.integer :case_id
      t.integer :intake_form_id
      t.timestamps
    end
  end
end
