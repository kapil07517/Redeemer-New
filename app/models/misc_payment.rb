class MiscPayment < ActiveRecord::Base
  attr_accessible :books, :conferences, :assesments
  validates :books, :conferences, :assesments,:presence => true
end
