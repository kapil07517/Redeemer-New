class CreateIntakeEvalutions < ActiveRecord::Migration
  def change
    create_table :intake_evalutions do |t|
      t.integer :client_id
      t.integer :case_id
      t.text :psychosocial_history
      t.text :past_psychiatric_and_treatment
      t.text :medical_history
      t.string :risk_physical_history
      t.string  :homicidality
      t.string :violent
      t.string :able_to_care_self
      t.text :if_not_explain
      t.text :risks_of_harm_to_self
      t.text :safty_plan_for_high_risk
      t.string :individual_psycho_1
      t.string :individual_psycho_2
      t.string :plan
      t.string :intent
      t.string :patient_agreed_to_safty_plan
      t.string :dental
      t.text :whom_referal_made
      t.string :intake_gaf
      t.string :discharge_gaf
      t.boolean :is_draft,:default => false
      t.timestamps
    end
  end
end
