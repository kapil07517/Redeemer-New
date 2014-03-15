class Room < ActiveRecord::Base
  attr_accessible :name, :description, :status
  validates :name, :description, :presence => true
  has_many :appointments,:dependent => :destroy
end
