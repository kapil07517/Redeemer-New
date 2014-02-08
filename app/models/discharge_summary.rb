class DischargeSummary < ActiveRecord::Base
  attr_accessible :client_id,:case_id,:intake_date,:last_session,:discharge_date,:termination_type,:treatment_mode_individual,:treatment_mode_family,:treatment_mode_group,:treatment_mode_other,:reason_for_discharge,:summary_of_areas,:expectation_of_future,:intake_gaf,:discharge_gaf,:is_draft,:password
  belongs_to :client
  belongs_to :case
  has_one :document,:dependent => :destroy
  validates :intake_date,:last_session,:discharge_date,:termination_type,:presence => true
end
