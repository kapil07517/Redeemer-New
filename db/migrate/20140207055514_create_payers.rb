class CreatePayers < ActiveRecord::Migration
  def change
    create_table :payers do |t|
      t.string :name_of_org
      t.string :contact_person
      t.text :address
      t.string :phone_no
      t.string :fax_no
      t.string :email
      t.timestamps
    end
  end
end
