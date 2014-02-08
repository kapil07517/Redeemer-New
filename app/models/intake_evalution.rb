class IntakeEvalution < ActiveRecord::Base
  attr_accessible :client_id,:case_id,:psychosocial_history,:past_psychiatric_and_treatment,:medical_history,:risk_physical_history,:homicidality,:violent,:able_to_care_self,:if_not_explain,:risks_of_harm_to_self,
    :safty_plan_for_high_risk,:individual_psycho_1,:individual_psycho_2,:plan,:intent,:patient_agreed_to_safty_plan,:dental,:whom_referal_made,:intake_gaf,:discharge_gaf,:is_draft
  belongs_to :client
  belongs_to :case
  has_one :document,:dependent => :destroy
  validates :psychosocial_history,:past_psychiatric_and_treatment,:medical_history,:risk_physical_history,:homicidality,:violent,:able_to_care_self,:if_not_explain,:risks_of_harm_to_self,:presence => true
end
