class CreateAdolesmentIntakes < ActiveRecord::Migration
  def change
    create_table :adolesment_intakes do |t|
      t.integer :client_id
      t.integer :case_id
      t.string :name
      t.date :date_of_birth
      t.string :lives_with
      t.string :school
      t.string :grade
      t.text :activities_and_interests
      t.string :job
      t.string :do_you_believe_in_god
      t.string :relegious_preference
      t.text :pursue_counseling
      t.string :rate_issue
      t.text :other_concerns_to_address
      t.timestamps
    end
  end
end
