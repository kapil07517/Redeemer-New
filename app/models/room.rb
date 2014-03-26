class Room < ActiveRecord::Base
  attr_accessible :name, :description, :status
  validates :name, :description, :presence => true
  has_many :appointments,:dependent => :destroy
  has_many :counselor_availabilities,:dependent => :destroy
end
