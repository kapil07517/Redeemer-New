class AddReducedFeeIdToDocuments < ActiveRecord::Migration
  def change
    remove_column :reduced_fees,:intake_form_id
    add_column :documents,:reduced_fee_id,:integer
  end
end
