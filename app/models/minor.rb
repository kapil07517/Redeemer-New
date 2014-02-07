class Minor < ActiveRecord::Base
 attr_accessible :client_id,:marital_status,:date_of_marriage,:no_of_marriages,:guardian_name,:guardian_address,:guardian_text,:g_city,:g_state,:g_zip,:consent_from_other_parent,:how_much_contact_child_have,:m_name,:m_date_of_birth,:m_lives_with,:m_school,:m_grade1,:m_grade2,:m_grade3,
    :m_activities_and_interests,:concerns_about_child_have,:your_concern_problems,:problems_expl,:concerns_for_child,:child_problem_expl,:present_concerns_child,:any_other_ident_concerns,:following_areas_child_prob,:following_areas_child_prob_expl,:child_gain_counseling,:counselor_preference,:content_and_sig,:online_sig,:childrens_attributes,:intake_type
  attr_accessor :intake_type
  belongs_to :client
  belongs_to :intake_form
  has_many :childrens,:dependent => :destroy
  accepts_nested_attributes_for  :childrens, :reject_if => lambda { |a| a[:child_name].blank? },  :allow_destroy  => true
  validates :counselor_preference,:presence => true
end
