class CreateCaseCounselors < ActiveRecord::Migration
  def change
    create_table :case_counselors do |t|
      t.integer :counselor_id
      t.integer :case_id
      t.timestamps
    end
  end
end
