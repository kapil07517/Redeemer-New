class CreateMedicals < ActiveRecord::Migration
  def change
    create_table :medicals do |t|
      t.integer :client_id
      t.integer :intake_form_id
      t.integer :minor_id
      t.string :rate_your_current_p_health
      t.string :rate_your_child_p_health
      t.date :date_of_last_p_exam
      t.string :e_physical_problems
      t.string :child_complaining_of_prob
      t.text :p_explain
      t.text :list_medical_cond_child
      t.string :child_mental_illness
      t.text :e_known_cond
      t.string :any_one_family_diagnosized
      t.string :child_before_counseling
      t.string :how_long
      t.text :reason
      t.string :name_of_prev_counselor
      t.string :hospitalized_for_physical_purposes
      t.text :hospital_location_and_dates
      t.string :counseling_before
      t.string :permission_to_previous_counsellors
      t.text :results_of_previous_counseling
      t.text :gain_from_counseling
      t.timestamps
    end
  end
end
