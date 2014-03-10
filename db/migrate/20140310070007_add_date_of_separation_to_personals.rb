class AddDateOfSeparationToPersonals < ActiveRecord::Migration
  def change
    add_column :personals,:date_of_seperation,:date
  end
end
