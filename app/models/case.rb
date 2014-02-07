class Case < ActiveRecord::Base
  attr_accessible :counselor_id,:intake_form_id,:number,:case_name,:status,:prefix,:extension
  attr_accessor :prefix,:extension
  belongs_to :counselor
  belongs_to :intake_form
  has_many :documents
  has_many :case_intake_forms,:dependent => :destroy
  has_many :forms,:class_name => "IntakeForm"
  has_many :reminders,:dependent => :destroy
  has_many :appointments,:dependent => :destroy
  validates :prefix,:extension,:case_name,:presence => true
  before_create :combine_case_number
  
  def combine_case_number
    self.number = self.prefix+"-"+self.extension
  end
end
