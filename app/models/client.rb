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
end
