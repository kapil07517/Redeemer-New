class AddRoomIdToCounselorAvailabilities < ActiveRecord::Migration
  def change
    add_column :counselor_availabilities,:room_id,:integer
    remove_column :counselor_availabilities,:title
    remove_column :counselor_availabilities,:description
  end
end
