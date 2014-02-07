class CptCode < ActiveRecord::Base
  attr_accessible :cpt_code, :description
   validates :cpt_code, :description, :presence => true
end
