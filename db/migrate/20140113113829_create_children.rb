class CreateChildren < ActiveRecord::Migration
  def change
    create_table :children do |t|
      t.integer :minor_id
      t.string :child_name
      t.string :gender
      t.date :date_of_birth
      t.timestamps
    end
  end
end
