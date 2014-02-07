class CreateClientAvailabilities < ActiveRecord::Migration
  def change
    create_table :client_availabilities do |t|
      t.integer :client_id
      t.integer :intake_form_id
      t.datetime :start_at
      t.datetime :end_at
      t.timestamps
    end
  end
end
