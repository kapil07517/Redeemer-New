class CreateCounselings < ActiveRecord::Migration
  def change
    create_table :counselings do |t|
      t.integer :intake_form_id
      t.integer :client_id
      t.text :concern_led
      t.string :concern_counseling_problems
      t.text :present_concern
      t.text :have_any_concerns_identified
      t.string :rate_of_present_concern
      t.string :areas_of_problems
      t.string :counselor_preference
      t.timestamps
    end
  end
end
