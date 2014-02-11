class Client < User
  has_many :counselings,:dependent => :destroy
  has_many :medicals,:dependent => :destroy
  has_many :personals,:dependent => :destroy
  has_many :client_availabilities,:dependent => :destroy
  has_many :partners,:dependent => :destroy
  has_many :reduced_fees,:dependent => :destroy
  has_many :minors,:dependent => :destroy
  has_many :documents
  has_many :reminders,:dependent => :destroy
  has_many :appointments,:dependent => :destroy
  has_many :intake_evalutions,:dependent => :destroy
  has_many :discharge_summaries,:dependent => :destroy
  has_many :adolesment_intakes,:dependent => :destroy
  has_many :session_payments,:dependent => :destroy
  has_many :miscellaneous_payments,:dependent => :destroy
  has_many :payer_accounts,:dependent => :destroy
end
