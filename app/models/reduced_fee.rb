class ReducedFee < ActiveRecord::Base
  attr_accessible :job_type,:hours_per_week,:employer,:student_job_type,:school,:unemployeed,:date_of_last_empl,:gross_monthly_wages_p_income,:gross_monthly_wages_o_income,:income_from_other,:total_income,:other_income_e_name,:relationship_to_you,:occupation_and_status,:h_employer,:other_incomed_e_household,:no_of_dependants,
    :total_no_of_household,:most_recent_tax,:most_recent_tax_year,:tax_single_join,:e_changed_last_tax_return,:explain,:out_of_network_insurance,:additional_information,:comments,:doc_password,:content_and_signature,:online_signature,:avatar,:dependents_attributes,:client_id
  has_attached_file :avatar
  belongs_to :client
  has_many :dependents,:dependent => :destroy
  has_one :document,:dependent => :destroy
  accepts_nested_attributes_for  :dependents, :reject_if => lambda { |a| a[:name].blank? },  :allow_destroy  => true
  validates_acceptance_of :online_signature, :message => "You must first agree to the online signature"
end
