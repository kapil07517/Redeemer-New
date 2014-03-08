class AddStartDateToPayerAccounts < ActiveRecord::Migration
  def change
    add_column :payer_accounts,:start_date,:date
  end
end
