class Medical < ActiveRecord::Base
  attr_accessible :client_id,:intake_form_id,:rate_your_current_p_health,:date_of_last_p_exam,:e_physical_problems,:p_explain,:hospitalized_for_physical_purposes,:hospital_location_and_dates,:counseling_before,:permission_to_previous_counsellors,:results_of_previous_counseling,:gain_from_counseling,:medical_reasons_attributes, :therapists_attributes, :medications_attributes,
    :rate_your_child_p_health, :child_complaining_of_prob, :list_medical_cond_child, :child_mental_illness, :e_known_cond, :how_long, :reason, :name_of_prev_counselor,:any_one_family_diagnosized, :child_before_counseling
  belongs_to :client
  belongs_to :intake_form
  belongs_to :minor
  has_many :medical_reasons,:dependent => :destroy
  has_many :medications,:dependent => :destroy
  has_many :therapists,:dependent => :destroy
  accepts_nested_attributes_for  :medical_reasons, :reject_if => lambda { |a| a[:previous_hospital].blank? },  :allow_destroy  => true
  accepts_nested_attributes_for  :medications, :reject_if => lambda { |a| a[:medician].blank? },  :allow_destroy  => true
  accepts_nested_attributes_for  :therapists, :reject_if => lambda { |a| a[:full_name].blank? },  :allow_destroy  => true
end
