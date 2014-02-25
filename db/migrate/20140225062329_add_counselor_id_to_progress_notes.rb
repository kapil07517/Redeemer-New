class AddCounselorIdToProgressNotes < ActiveRecord::Migration
  def change
    add_column :progress_notes,:counselor_id,:integer
  end
end
