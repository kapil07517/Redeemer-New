class CreateCounselorPermissions < ActiveRecord::Migration
  def change
    create_table :counselor_permissions do |t|
      t.integer :counselor_id
      t.integer :case_id
      t.string :permission
      t.timestamps
    end
  end
end
