class SessionPayment < ActiveRecord::Base
  attr_accessible :case_id,:client_id,:payer_id,:appointment_id,:session_date,:amount,
    :payment_type,:payment_amount,:comment,:session_status,:auth,:fee,:copay,:debit,:balance,:uos,:owes,:action_name,:payment_name
  attr_accessor :action_name,:payment_name
  belongs_to :case
  belongs_to :client
  belongs_to :payer
  belongs_to :appointment
  validates :case_id,:amount,:payment_amount,:payment_type,:session_date,:payment_name,:presence => true,:if => lambda{ |object| object.action_name == 'accounting' }
  validates :amount,:fee,:payment_type,:session_status,:uos,:presence => true,:if => lambda{ |object| object.action_name != 'accounting' }
end
