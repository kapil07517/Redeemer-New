class Note < ActiveRecord::Base
  attr_accessible :description, :notable_id, :notable_type
  belongs_to :intake_form, :polymorphic => true
  validates :description, :presence => true
end
