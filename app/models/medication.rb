class Medication < ActiveRecord::Base
  attr_accessible :medician,:dosage
   belongs_to :medical
end
