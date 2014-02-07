class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.integer :case_id
      t.integer :counselor_id
      t.integer :intake_form_id
      t.integer :client_id
      t.datetime :start_at
      t.datetime :end_at
      t.string :status
      t.timestamps
    end
  end
end
