class AdolesmentIntake < ActiveRecord::Base
  attr_accessible :case_id,:client_id,:name,:date_of_birth,:lives_with,:school,:grade,:activities_and_interests,:job,:do_you_believe_in_god,:relegious_preference,:pursue_counseling,:rate_issue,:other_concerns_to_address
  belongs_to :case
  belongs_to :client
  has_one :document,:dependent => :destroy
  validates :name,:date_of_birth,:lives_with,:presence => true
end
