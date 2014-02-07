class Children < ActiveRecord::Base
  attr_accessible :child_name,:gender,:date_of_birth
  belongs_to :minor
end
