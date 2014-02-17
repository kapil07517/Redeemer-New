class CreateSessionFees < ActiveRecord::Migration
  def change
    create_table :session_fees do |t|
      t.integer :case_id
      t.float :fee
      t.date :start_date
      t.timestamps
    end
  end
end
