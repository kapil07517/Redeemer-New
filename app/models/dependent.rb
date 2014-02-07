class Dependent < ActiveRecord::Base
  attr_accessible :name,:age
  belongs_to :reduced_fee
end
