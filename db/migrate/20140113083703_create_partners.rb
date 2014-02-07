class CreatePartners < ActiveRecord::Migration
  def change
    create_table :partners do |t|
      t.integer :client_id
      t.string :name
      t.date :date_of_birth
      t.string :email
      t.string :is_minor
      t.string :intake_type
      t.timestamps
    end
  end
end
