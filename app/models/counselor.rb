class Counselor < User
  has_many :counselor_availabilities,:dependent => :destroy
  has_many :cases
  has_many :appointments,:dependent => :destroy
  has_many :counselor_permissions, :dependent => :destroy
end
