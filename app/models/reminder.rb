class Reminder < ActiveRecord::Base
  attr_accessible :case_id,:client_id,:description,:hidden,:counselor_id
  validates :description,:presence => true
  belongs_to :client
  belongs_to :case
  belongs_to :counselor
end
