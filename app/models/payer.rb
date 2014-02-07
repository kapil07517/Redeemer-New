class Payer < ActiveRecord::Base
   attr_accessible :name_of_org,:contact_person,:email,:phone_no,:fax_no,:address
   validates :name_of_org,:contact_person,:email,:phone_no,:fax_no,:address,:presence => true
end
