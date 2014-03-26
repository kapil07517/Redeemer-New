# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140320112909) do

  create_table "adolesment_intakes", :force => true do |t|
    t.integer  "client_id"
    t.integer  "case_id"
    t.string   "name"
    t.date     "date_of_birth"
    t.string   "lives_with"
    t.string   "school"
    t.string   "grade"
    t.text     "activities_and_interests"
    t.string   "job"
    t.string   "do_you_believe_in_god"
    t.string   "relegious_preference"
    t.text     "pursue_counseling"
    t.string   "rate_issue"
    t.text     "other_concerns_to_address"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "appointments", :force => true do |t|
    t.integer  "case_id"
    t.datetime "start_at"
    t.datetime "end_at"
    t.string   "status"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.integer  "room_id"
    t.integer  "counselor_id"
    t.integer  "counselor_availability_id"
  end

  create_table "case_clients", :force => true do |t|
    t.integer  "case_id"
    t.integer  "client_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "case_counselors", :force => true do |t|
    t.integer  "counselor_id"
    t.integer  "case_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "case_intake_forms", :force => true do |t|
    t.integer  "case_id"
    t.integer  "intake_form_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "case_prefixes", :force => true do |t|
    t.string   "prefix"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "cases", :force => true do |t|
    t.string   "number"
    t.string   "case_name"
    t.integer  "counselor_id"
    t.integer  "intake_form_id"
    t.string   "status",         :default => "inactive"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  create_table "children", :force => true do |t|
    t.integer  "minor_id"
    t.string   "child_name"
    t.string   "gender"
    t.date     "date_of_birth"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "client_availabilities", :force => true do |t|
    t.integer  "client_id"
    t.integer  "intake_form_id"
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "counselings", :force => true do |t|
    t.integer  "intake_form_id"
    t.integer  "client_id"
    t.text     "concern_led"
    t.string   "concern_counseling_problems"
    t.text     "present_concern"
    t.text     "have_any_concerns_identified"
    t.string   "rate_of_present_concern"
    t.string   "areas_of_problems"
    t.string   "counselor_preference"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  create_table "counselor_availabilities", :force => true do |t|
    t.integer  "counselor_id"
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "room_id"
  end

  create_table "counselor_permissions", :force => true do |t|
    t.integer  "counselor_id"
    t.integer  "case_id"
    t.string   "permission"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "cpt_codes", :force => true do |t|
    t.string   "cpt_code"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "dependents", :force => true do |t|
    t.integer  "reduced_fee_id"
    t.string   "name"
    t.string   "age"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "discharge_summaries", :force => true do |t|
    t.integer  "client_id"
    t.integer  "case_id"
    t.date     "intake_date"
    t.string   "last_session"
    t.date     "discharge_date"
    t.string   "termination_type"
    t.string   "treatment_mode_individual"
    t.string   "treatment_mode_family"
    t.string   "treatment_mode_group"
    t.string   "treatment_mode_other"
    t.text     "reason_for_discharge"
    t.text     "summary_of_areas"
    t.text     "expectation_of_future"
    t.string   "intake_gaf"
    t.string   "discharge_gaf"
    t.boolean  "is_draft"
    t.string   "password"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "documents", :force => true do |t|
    t.integer  "case_id"
    t.integer  "client_id"
    t.integer  "intake_form_id"
    t.integer  "progress_note_id"
    t.integer  "adolesment_intake_id"
    t.integer  "discharge_summary_id"
    t.integer  "intake_evalution_id"
    t.string   "doc_type"
    t.string   "document_file_name"
    t.string   "document_content_type"
    t.integer  "document_file_size"
    t.datetime "document_updated_at"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.integer  "reduced_fee_id"
    t.text     "description"
    t.integer  "user_id"
  end

  create_table "intake_evalutions", :force => true do |t|
    t.integer  "client_id"
    t.integer  "case_id"
    t.text     "psychosocial_history"
    t.text     "past_psychiatric_and_treatment"
    t.text     "medical_history"
    t.string   "risk_physical_history"
    t.string   "homicidality"
    t.string   "violent"
    t.string   "able_to_care_self"
    t.text     "if_not_explain"
    t.text     "risks_of_harm_to_self"
    t.text     "safty_plan_for_high_risk"
    t.string   "individual_psycho_1"
    t.string   "individual_psycho_2"
    t.string   "plan"
    t.string   "intent"
    t.string   "patient_agreed_to_safty_plan"
    t.string   "dental"
    t.text     "whom_referal_made"
    t.string   "intake_gaf"
    t.string   "discharge_gaf"
    t.boolean  "is_draft",                       :default => false
    t.datetime "created_at",                                        :null => false
    t.datetime "updated_at",                                        :null => false
  end

  create_table "intake_forms", :force => true do |t|
    t.integer  "user_id"
    t.string   "intake_type"
    t.string   "intake_status"
    t.integer  "case_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "medical_reasons", :force => true do |t|
    t.integer  "medical_id"
    t.string   "previous_hospital"
    t.date     "previous_hospital_date"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

  create_table "medicals", :force => true do |t|
    t.integer  "client_id"
    t.integer  "intake_form_id"
    t.integer  "minor_id"
    t.string   "rate_your_current_p_health"
    t.string   "rate_your_child_p_health"
    t.date     "date_of_last_p_exam"
    t.string   "e_physical_problems"
    t.string   "child_complaining_of_prob"
    t.text     "p_explain"
    t.text     "list_medical_cond_child"
    t.string   "child_mental_illness"
    t.text     "e_known_cond"
    t.string   "any_one_family_diagnosized"
    t.string   "child_before_counseling"
    t.string   "how_long"
    t.text     "reason"
    t.string   "name_of_prev_counselor"
    t.string   "hospitalized_for_physical_purposes"
    t.text     "hospital_location_and_dates"
    t.string   "counseling_before"
    t.string   "permission_to_previous_counsellors"
    t.text     "results_of_previous_counseling"
    t.text     "gain_from_counseling"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  create_table "medications", :force => true do |t|
    t.integer  "medical_id"
    t.string   "medician"
    t.string   "dosage"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "minors", :force => true do |t|
    t.integer  "client_id"
    t.integer  "intake_form_id"
    t.string   "marital_status"
    t.date     "date_of_marriage"
    t.integer  "no_of_marriages"
    t.string   "guardian_name"
    t.string   "guardian_address"
    t.text     "guardian_text"
    t.string   "g_city"
    t.string   "g_state"
    t.string   "g_zip"
    t.string   "consent_from_other_parent"
    t.string   "contact_phone"
    t.string   "contact_email"
    t.string   "contact_preference"
    t.text     "how_much_contact_child_have"
    t.string   "m_name"
    t.date     "m_date_of_birth"
    t.string   "m_lives_with"
    t.string   "m_school"
    t.string   "m_grade1"
    t.string   "m_grade2"
    t.string   "m_grade3"
    t.text     "m_activities_and_interests"
    t.text     "concerns_about_child_have"
    t.string   "your_concern_problems"
    t.text     "problems_expl"
    t.string   "concerns_for_child"
    t.text     "child_problem_expl"
    t.text     "present_concerns_child"
    t.text     "any_other_ident_concerns"
    t.string   "following_areas_child_prob"
    t.text     "following_areas_child_prob_expl"
    t.text     "child_gain_counseling"
    t.string   "counselor_preference"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  create_table "misc_payments", :force => true do |t|
    t.string   "books"
    t.string   "assesments"
    t.string   "conferences"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "miscellaneous_payments", :force => true do |t|
    t.integer  "client_id"
    t.integer  "case_id"
    t.date     "pay_date"
    t.string   "description"
    t.string   "payment_type"
    t.string   "item"
    t.text     "comment"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "notes", :force => true do |t|
    t.integer  "notable_id"
    t.string   "notable_type"
    t.text     "description"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "partners", :force => true do |t|
    t.integer  "client_id"
    t.string   "name"
    t.date     "date_of_birth"
    t.string   "email"
    t.string   "is_minor"
    t.string   "intake_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "payer_accounts", :force => true do |t|
    t.integer  "case_id"
    t.integer  "client_id"
    t.integer  "payer_id"
    t.string   "auth"
    t.string   "amount"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.date     "start_date"
  end

  create_table "payers", :force => true do |t|
    t.string   "name_of_org"
    t.string   "contact_person"
    t.text     "address"
    t.string   "phone_no"
    t.string   "fax_no"
    t.string   "email"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "personals", :force => true do |t|
    t.integer  "client_id"
    t.integer  "intake_form_id"
    t.integer  "minor_id"
    t.string   "marital_status"
    t.date     "date_of_marriage"
    t.integer  "no_of_marriages"
    t.string   "spouse_name"
    t.date     "date_of_birth"
    t.text     "spouse_address"
    t.text     "spouse_email"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
    t.string   "ph_no"
    t.integer  "no_of_children"
    t.string   "age1"
    t.string   "age2"
    t.string   "age3"
    t.string   "living_with"
    t.string   "attending_counselor_together"
    t.string   "occupation"
    t.string   "status"
    t.string   "employer"
    t.string   "annual_income"
    t.string   "time_with_current_emp"
    t.string   "school"
    t.string   "field_of_study"
    t.string   "degree"
    t.string   "student_status"
    t.string   "believe_in_god"
    t.string   "religious_preference"
    t.string   "current_church"
    t.string   "member_of_redeemer_church"
    t.string   "day_to_day_activity"
    t.text     "concerns_led_you"
    t.text     "gain_through_counseling"
    t.string   "referred_you_to_redeemer"
    t.string   "satisfy_occupation"
    t.string   "previous_occupation"
    t.date     "grade_date"
    t.string   "acts_as_online_sig"
    t.string   "password"
    t.date     "p_date"
    t.string   "content_and_signature"
    t.string   "online_signature"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.date     "date_of_seperation"
  end

  create_table "progress_notes", :force => true do |t|
    t.integer  "appointment_id"
    t.string   "status"
    t.boolean  "is_draft"
    t.text     "objective"
    t.text     "assesment"
    t.text     "plan"
    t.text     "subjective"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "counselor_id"
  end

  create_table "reduced_fees", :force => true do |t|
    t.integer  "client_id"
    t.string   "job_type"
    t.string   "hours_per_week"
    t.string   "employer"
    t.string   "student_job_type"
    t.string   "school"
    t.string   "unemployeed"
    t.date     "date_of_last_empl"
    t.string   "gross_monthly_wages_p_income"
    t.string   "gross_monthly_wages_o_income"
    t.string   "income_from_other"
    t.string   "total_income"
    t.string   "other_income_e_name"
    t.string   "relationship_to_you"
    t.string   "occupation_and_status"
    t.string   "h_employer"
    t.string   "other_incomed_e_household"
    t.integer  "no_of_dependants"
    t.integer  "total_no_of_household"
    t.string   "most_recent_tax"
    t.string   "most_recent_tax_year"
    t.string   "tax_single_join"
    t.string   "e_changed_last_tax_return"
    t.text     "explain"
    t.text     "out_of_network_insurance"
    t.text     "additional_information"
    t.text     "comments"
    t.string   "doc_password"
    t.string   "content_and_signature"
    t.string   "online_signature"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  create_table "reminders", :force => true do |t|
    t.integer  "client_id"
    t.integer  "case_id"
    t.string   "description"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.boolean  "hidden",       :default => false
    t.integer  "counselor_id"
  end

  create_table "renewal_groups", :force => true do |t|
    t.integer  "user_id"
    t.text     "question"
    t.text     "answer"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "rooms", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "status"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "session_fees", :force => true do |t|
    t.integer  "case_id"
    t.float    "fee"
    t.date     "start_date"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "session_payments", :force => true do |t|
    t.integer  "client_id"
    t.integer  "case_id"
    t.integer  "appointment_id"
    t.integer  "payer_id"
    t.date     "session_date"
    t.string   "amount"
    t.string   "payment_type"
    t.string   "payment_amount"
    t.text     "comment"
    t.string   "session_status"
    t.string   "auth"
    t.string   "fee"
    t.string   "copay"
    t.string   "debit"
    t.string   "balance"
    t.string   "uos"
    t.string   "owes"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "therapists", :force => true do |t|
    t.integer  "medical_id"
    t.string   "full_name"
    t.string   "location"
    t.date     "therapy_date"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",       :null => false
    t.string   "encrypted_password",     :default => "",       :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "role"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "type"
    t.string   "middle_initial"
    t.text     "address"
    t.text     "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
    t.string   "apt_code"
    t.string   "mobile"
    t.string   "home"
    t.string   "work"
    t.string   "primary"
    t.string   "gender"
    t.date     "date_of_birth"
    t.string   "who_refered"
    t.text     "about_us"
    t.string   "status",                 :default => "active"
    t.string   "contact_name"
    t.string   "relationship"
    t.string   "contact_email"
    t.string   "contact_phone"
    t.string   "emergency_contact"
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
    t.string   "account_id"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
