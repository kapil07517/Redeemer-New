class CreateMiscPayments < ActiveRecord::Migration
  def change
    create_table :misc_payments do |t|
      t.string :books
      t.string :assesments
      t.string :conferences
      t.timestamps
    end
  end
end
