class Room < ActiveRecord::Base
  attr_accessible :name, :description, :status
  validates :name, :description, :presence => true
end
