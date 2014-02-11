class PayerAccount < ActiveRecord::Base
  attr_accessible :case_id,:client_id,:payer_id,:auth,:amount
  validates :case_id,:client_id,:payer_id,:auth,:amount,:presence => true
  belongs_to :client
  belongs_to :case
  belongs_to :payer
end
