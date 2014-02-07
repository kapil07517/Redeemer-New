class CreateCasePrefixes < ActiveRecord::Migration
  def change
    create_table :case_prefixes do |t|
      t.string :prefix
      t.text :description
      t.timestamps
    end
  end
end
