class Reminder < ActiveRecord::Base
  attr_accessible :case_id,:client_id,:description
  validates :description,:presence => true
  belongs_to :client
  belongs_to :case
end
