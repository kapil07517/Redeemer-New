class CaseClient < ActiveRecord::Base
  attr_accessible :case_id,:client_id
  belongs_to :case
  belongs_to :client
end
