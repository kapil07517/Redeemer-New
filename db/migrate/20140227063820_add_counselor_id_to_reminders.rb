class AddCounselorIdToReminders < ActiveRecord::Migration
  def change
    add_column :reminders,:counselor_id,:integer
  end
end
