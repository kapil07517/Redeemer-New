class SessionFee < ActiveRecord::Base
  attr_accessible :case_id, :fee, :start_date
  belongs_to :case
  
  validates :fee, :presence => true
end
