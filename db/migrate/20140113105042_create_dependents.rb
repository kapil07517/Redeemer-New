class CreateDependents < ActiveRecord::Migration
  def change
    create_table :dependents do |t|
      t.integer :reduced_fee_id
      t.string :name
      t.string :age
      t.timestamps
    end
  end
end
