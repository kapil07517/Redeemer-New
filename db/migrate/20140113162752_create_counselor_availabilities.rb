class CreateCounselorAvailabilities < ActiveRecord::Migration
  def change
    create_table :counselor_availabilities do |t|
      t.integer :counselor_id
      t.string :title
      t.text :description
      t.datetime :start_at
      t.datetime :end_at
      t.timestamps
    end
  end
end
