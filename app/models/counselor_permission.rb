class CounselorPermission < ActiveRecord::Base
  attr_accessible :case_id,:counselor_id,:permission
  belongs_to :case
  belongs_to :counselor
end
