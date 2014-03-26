class RemoveClientIdFromAppointments < ActiveRecord::Migration
  def up
    add_column :appointments,:counselor_availability_id,:integer
    remove_column :appointments,:client_id
    remove_column :appointments,:intake_form_id
  end

  def down
    remove_column :appointments,:counselor_availability_id
    add_column :appointments,:client_id,:integer
    add_column :appointments,:intake_form_id,:integer
  end
end
