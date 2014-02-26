class AddHiddenToReminders < ActiveRecord::Migration
  def change
    add_column :reminders,:hidden,:boolean,:default => false
  end
end
