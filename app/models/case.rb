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
  has_many :intake_evalutions,:dependent => :destroy
  has_many :discharge_summaries,:dependent => :destroy
  has_many :adolesment_intakes,:dependent => :destroy
  has_many :session_payments,:dependent => :destroy
  has_many :miscellaneous_payments,:dependent => :destroy
  has_many :payer_accounts,:dependent => :destroy
  has_many :case_clients,:dependent => :destroy
  has_many :session_fees, :dependent => :destroy
  validates :prefix,:extension,:case_name,:presence => true
  before_create :combine_case_number
  validate :case_number,:on => :create
  
  def combine_case_number
    self.number = self.prefix+"-"+self.extension
  end
  
  def case_number
    cs = Case.find_by_number(self.prefix+"-"+self.extension)
    if cs
      errors.add(:extension,"already we have this case")
    end
  end
end
