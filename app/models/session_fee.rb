class SessionFee < ActiveRecord::Base
  attr_accessible :case_id, :fee, :start_date
  belongs_to :case
  
  validates :fee,:case_id, :start_date, :presence => true
end
