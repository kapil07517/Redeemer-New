class ProgressNote < ActiveRecord::Base
  attr_accessible :appointment_id,:counselor_id,:status,:is_draft,:objective,:assesment,:plan,:subjective,:password
  attr_accessor :password
  belongs_to :appointment
  belongs_to :counselor
  has_one :document,:dependent => :destroy
  validates :objective,:assesment,:plan,:subjective,:presence => true
end
