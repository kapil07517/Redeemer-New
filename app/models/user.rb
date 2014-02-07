class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable, :confirmable, :token_authenticatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,:role, :type, :first_name, :middle_initial,
    :last_name, :address, :city, :state, :zipcode, :mobile, :work, :home, :date_of_birth, :who_refered, :about_us,
    :contact_name, :relationship, :contact_phone, :contact_email,:confirmation_token, :confirmed_at,:primary,:gender,:emergency_contact,:address2,:status
  # attr_accessible :title, :body
  
  validates :first_name,:last_name,:type,:role,:presence => true
  validate :client_information ,:on => :update
  has_many :intake_forms,:dependent => :destroy
  def client_information
    if self.role == 'client'
      errors.add(:middle_initial,"Can't be blank") if self.middle_initial.blank?
      errors.add(:contact_name,"Can't be blank") if self.contact_name.blank?
      errors.add(:address,"Can't be blank") if self.address.blank?
      errors.add(:date_of_birth,"Can't be blank") if self.date_of_birth.blank?
      errors.add(:contact_phone,"Can't be blank") if self.contact_phone.blank?
    end
  end
  
  def full_name
    self.first_name+' '+self.last_name
  end
end
