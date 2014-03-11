class CaseCounselor < ActiveRecord::Base
   attr_accessible :case_id,:counselor_id
   belongs_to :case
   belongs_to :counselor
end
