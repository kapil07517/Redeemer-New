class CreateDischargeSummaries < ActiveRecord::Migration
  def change
    create_table :discharge_summaries do |t|
      t.integer :client_id
      t.integer :case_id
      t.date :intake_date
      t.string :last_session
      t.date :discharge_date
      t.string :termination_type
      t.string :treatment_mode_individual
      t.string :treatment_mode_family
      t.string :treatment_mode_group
      t.string :treatment_mode_other
      t.text :reason_for_discharge
      t.text :summary_of_areas
      t.text :expectation_of_future
      t.string :intake_gaf
      t.string :discharge_gaf
      t.boolean :is_draft
      t.string :password
      t.timestamps
    end
  end
end
