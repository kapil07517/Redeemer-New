class CreateReminders < ActiveRecord::Migration
  def change
    create_table :reminders do |t|
      t.integer :client_id
      t.integer :case_id
      t.string :description
      t.timestamps
    end
  end
end
