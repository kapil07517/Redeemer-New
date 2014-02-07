class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.integer :case_id
      t.integer :client_id
      t.integer :intake_form_id
      t.integer :progress_note_id
      t.integer :adolesment_intake_id
      t.integer :discharge_summary_id
      t.integer :intake_evalution_id
      t.string :doc_type
      t.attachment :document
      t.timestamps
    end
  end
end
