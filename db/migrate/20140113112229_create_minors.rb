class CreateMinors < ActiveRecord::Migration
  def change
    create_table :minors do |t|
      t.integer :client_id
      t.integer :intake_form_id
      t.string :marital_status
      t.date :date_of_marriage
      t.integer :no_of_marriages
      t.string :guardian_name
      t.string :guardian_address
      t.text :guardian_text
      t.string :g_city
      t.string :g_state
      t.string :g_zip
      t.string :consent_from_other_parent
      t.string :contact_phone
      t.string :contact_email
      t.string :contact_preference
      t.text :how_much_contact_child_have
      t.string :m_name
      t.date :m_date_of_birth
      t.string :m_lives_with
      t.string :m_school
      t.string :m_grade1
      t.string :m_grade2
      t.string :m_grade3
      t.text :m_activities_and_interests
      t.text :concerns_about_child_have
      t.string :your_concern_problems
      t.text :problems_expl
      t.string :concerns_for_child
      t.text :child_problem_expl
      t.text :present_concerns_child
      t.text :any_other_ident_concerns
      t.string :following_areas_child_prob
      t.text :following_areas_child_prob_expl
      t.text :child_gain_counseling
      t.string :counselor_preference
      t.timestamps
    end
  end
end
