class Counselor < User
  has_many :counselor_availabilities,:dependent => :destroy
  has_many :cases
  has_many :appointments,:dependent => :destroy
  has_many :counselor_permissions, :dependent => :destroy
  has_many :progress_notes,:dependent => :destroy
  
  def initial
    self.first_name[0]+''+self.last_name[0]
  end
end
