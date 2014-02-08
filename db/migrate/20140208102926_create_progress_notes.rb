class CreateProgressNotes < ActiveRecord::Migration
  def change
    create_table :progress_notes do |t|
      t.integer :appointment_id
      t.string :status
      t.boolean :is_draft
      t.text :objective
      t.text :assesment
      t.text :plan
      t.text :subjective
      t.timestamps
    end
  end
end
