class CreatePayerAccounts < ActiveRecord::Migration
  def change
    create_table :payer_accounts do |t|
      t.integer :case_id
      t.integer :client_id
      t.integer :payer_id
      t.string :auth
      t.string :amount
      t.timestamps
    end
  end
end
