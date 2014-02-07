class CreatePersonals < ActiveRecord::Migration
  def change
    create_table :personals do |t|
      t.integer :client_id      
      t.integer :intake_form_id
      t.integer :minor_id
      t.string :marital_status
      t.date :date_of_marriage
      t.integer :no_of_marriages
      t.string :spouse_name
      t.date :date_of_birth
      t.text :spouse_address
      t.text :spouse_email
      t.string :city
      t.string :state
      t.string :zipcode
      t.string :ph_no
      t.integer :no_of_children
      t.string :age1
      t.string :age2
      t.string :age3
      t.string :living_with
      t.string :attending_counselor_together
      t.string :occupation
      t.string :status
      t.string :employer
      t.string :annual_income
      t.string :time_with_current_emp
      t.string :school
      t.string :field_of_study
      t.string :degree
      t.string :student_status
      t.string :believe_in_god
      t.string :religious_preference
      t.string :current_church
      t.string :member_of_redeemer_church
      t.string :day_to_day_activity
      t.text :concerns_led_you
      t.text :gain_through_counseling
      t.string :referred_you_to_redeemer
      t.string :time_with_current_emp
      t.string :satisfy_occupation
      t.string :previous_occupation
      t.date :grade_date
      t.string :acts_as_online_sig
      t.string :password
      t.date :p_date
      t.string :content_and_signature
      t.string :online_signature
      t.timestamps
    end
  end
end
