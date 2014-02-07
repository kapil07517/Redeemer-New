class ClientAvailability < ActiveRecord::Base
  attr_accessible :client_id,:intake_form_id,:start_at,:end_at
  belongs_to :client
  belongs_to :intake_form
end
