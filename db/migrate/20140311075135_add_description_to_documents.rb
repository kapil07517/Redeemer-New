class AddDescriptionToDocuments < ActiveRecord::Migration
  def change
    add_column :documents,:description,:text
    add_column :documents,:user_id,:integer
  end
end
