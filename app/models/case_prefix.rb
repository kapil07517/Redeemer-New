class CasePrefix < ActiveRecord::Base
   attr_accessible :prefix,:description
   validates :prefix,:presence => true
   validates_uniqueness_of :prefix
end
