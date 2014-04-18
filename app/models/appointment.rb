class Appointment < ActiveRecord::Base
  attr_accessible :case_id,:counselor_id,:intake_form_id,:room_id,:client_id,:start_at,:end_at,:status
  has_one :session_payment,:dependent => :destroy
  belongs_to :case
  belongs_to :counselor
  belongs_to :client
  belongs_to :intake_form
  belongs_to :room
  has_one :progress_note
  validates :case_id,:counselor_id,:presence => true
end
