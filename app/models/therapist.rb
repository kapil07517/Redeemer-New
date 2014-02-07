class Therapist < ActiveRecord::Base
  attr_accessible :full_name,:location,:therapy_date
  belongs_to :medical
end
