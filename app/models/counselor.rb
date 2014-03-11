class Counselor < User
  has_many :counselor_availabilities,:dependent => :destroy
  has_many :cases
  has_many :appointments,:dependent => :destroy
  has_many :counselor_permissions, :dependent => :destroy
  has_many :progress_notes,:dependent => :destroy
  has_many :reminders,:dependent => :destroy
  has_many :case_counselors,:dependent => :destroy
  def initial
    self.first_name[0]+''+self.last_name[0]
  end
end
