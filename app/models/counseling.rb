class Counseling < ActiveRecord::Base
  attr_accessible :intake_form_id,:client_id,:concern_led,:concern_counseling_problems,:present_concern,:have_any_concerns_identified,:rate_of_present_concern,:areas_of_problems,:counselor_preference,:intake_type
  attr_accessor :intake_type
  belongs_to :client
  belongs_to :intake_form
  validates :concern_led,:concern_counseling_problems,:presence => true
end
