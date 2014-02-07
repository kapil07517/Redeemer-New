class Partner < ActiveRecord::Base
  attr_accessible :name,:date_of_birth,:email,:is_minor,:intake_type,:client_id
  belongs_to :client
  validates :name,:date_of_birth,:email,:presence => true
end
