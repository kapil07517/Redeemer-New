class Personal < ActiveRecord::Base
  attr_accessible :client_id,:intake_type,:marital_status,:date_of_marriage,:no_of_marriages,:spouse_name,:date_of_birth,:spouse_address,:spouse_email,:city,:state,:zipcode,:ph_no,:no_of_children,:age1,:age2,:age3,
    :living_with,:occupation,:status,:employer,:annual_income,:time_with_current_emp,:school,:field_of_study,:degree,:student_status,:believe_in_god,:religious_preference,:current_church,:member_of_redeemer_church,
    :day_to_day_activity,:content_and_signature,:online_signature,:concerns_led_you, :gain_through_counseling, :referred_you_to_redeemer,:attending_counselor_together,:previous_occupation,:satisfy_occupation, :grade_date, :acts_as_online_sig, :password, :p_date
  attr_accessor :intake_type
  belongs_to :client
  belongs_to :intake_form
  belongs_to :minor
  validates_acceptance_of :online_signature, :message => "You must first agree to the online signature"
end
