class PayerAccount < ActiveRecord::Base
  attr_accessible :case_id,:client_id,:payer_id,:auth,:amount,:start_date
  validates :case_id,:client_id,:payer_id,:auth,:amount,:start_date,:presence => true
  belongs_to :client
  belongs_to :case
  belongs_to :payer
end
