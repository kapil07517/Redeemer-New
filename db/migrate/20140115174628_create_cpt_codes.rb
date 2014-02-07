class CreateCptCodes < ActiveRecord::Migration
  def change
    create_table :cpt_codes do |t|
      t.string :cpt_code
      t.text :description
      t.timestamps
    end
  end
end
