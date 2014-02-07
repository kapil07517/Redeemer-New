class MedicalReason < ActiveRecord::Base
  attr_accessible :previous_hospital,:previous_hospital_date
  belongs_to :medical
end
