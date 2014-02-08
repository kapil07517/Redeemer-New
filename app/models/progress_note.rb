class ProgressNote < ActiveRecord::Base
  attr_accessible :appointment_id,:status,:is_draft,:objective,:assesment,:plan,:subjective,:password
  attr_accessor :password
  belongs_to :appointment
  validates :objective,:assesment,:plan,:subjective,:presence => true
end
