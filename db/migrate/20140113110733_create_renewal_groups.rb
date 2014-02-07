class CreateRenewalGroups < ActiveRecord::Migration
  def change
    create_table :renewal_groups do |t|
      t.integer :user_id
      t.text :question
      t.text :answer
      t.timestamps
    end
  end
end
