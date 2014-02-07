class CreateReducedFees < ActiveRecord::Migration
  def change
    create_table :reduced_fees do |t|
      t.integer :intake_form_id
      t.integer :client_id
      t.string :job_type
      t.string :hours_per_week
      t.string :employer
      t.string :student_job_type
      t.string :school
      t.string :unemployeed
      t.date :date_of_last_empl
      t.string :gross_monthly_wages_p_income
      t.string :gross_monthly_wages_o_income
      t.string :income_from_other
      t.string :total_income
      t.string :other_income_e_name
      t.string :relationship_to_you
      t.string :occupation_and_status
      t.string :h_employer
      t.string :other_incomed_e_household
      t.integer :no_of_dependants
      t.integer :total_no_of_household
      t.string :most_recent_tax
      t.string :most_recent_tax_year
      t.string :tax_single_join
      t.string :e_changed_last_tax_return
      t.text :explain
      t.text :out_of_network_insurance
      t.text :additional_information
      t.text :comments
      t.string :doc_password
      t.string :content_and_signature
      t.string :online_signature
      t.has_attached_file :avatar
      t.timestamps
    end
  end
end
