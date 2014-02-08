class CreateMiscellaneousPayments < ActiveRecord::Migration
  def change
    create_table :miscellaneous_payments do |t|
      t.integer :client_id
      t.integer :case_id
      t.date :pay_date
      t.string :description
      t.string :payment_type
      t.string :item
      t.text :comment
      t.timestamps
    end
  end
end
