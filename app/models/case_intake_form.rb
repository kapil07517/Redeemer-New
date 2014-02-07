class CaseIntakeForm < ActiveRecord::Base
  attr_accessible :case_id,:intake_form_id
  belongs_to :case
  belongs_to :intake_form
end
