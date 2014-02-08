class CreateSessionPayments < ActiveRecord::Migration
  def change
    create_table :session_payments do |t|
      t.integer :client_id
      t.integer :case_id
      t.integer :appointment_id
      t.integer :payer_id
      t.date :session_date
      t.string :amount
      t.string :payment_type
      t.string :payment_amount
      t.text :comment
      t.string :session_status
      t.string :auth
      t.string :fee
      t.string :copay
      t.string :debit
      t.string :balance
      t.string :uos
      t.string :owes
      t.timestamps
    end
  end
end
