class MiscellaneousPayment < ActiveRecord::Base
  attr_accessible :case_id,:client_id,:pay_date,:item,:description,:comment,:payment_type
  belongs_to :case
  belongs_to :client
  validates :pay_date,:item,:description,:comment,:payment_type,:presence => true
end
