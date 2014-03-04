class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable, :confirmable, :token_authenticatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,:role, :type, :first_name, :middle_initial,
    :last_name, :address, :city, :state, :zipcode, :mobile, :work, :home, :date_of_birth, :who_refered, :about_us,
    :contact_name, :relationship, :contact_phone, :contact_email,:confirmation_token, :confirmed_at,:primary,:gender,:emergency_contact,:address2,:status,:account_id,:contact_name1,:contact_name2
  # attr_accessible :title, :body
  attr_accessor :contact_name1,:contact_name2
  
  validates :first_name,:last_name,:type,:role,:presence => true
  validate :client_information
  has_many :intake_forms,:dependent => :destroy
  before_create { generate_client_number(:account_id) }
  before_save :combine_contact_name
  
  def client_information
    if self.role == 'client'
      errors.add(:middle_initial,"Can't be blank") if self.middle_initial.blank?
      errors.add(:address,"Can't be blank") if self.address.blank?
      errors.add(:date_of_birth,"Can't be blank") if self.date_of_birth.blank?
      errors.add(:contact_phone,"Can't be blank") if self.contact_phone.blank?
      errors.add(:contact_name1,"Can't be blank") if self.contact_name1.blank?
      errors.add(:contact_name2,"Can't be blank") if self.contact_name2.blank?
    end
  end
  
  def full_name
    self.first_name+' '+self.last_name
  end
  
  def generate_client_number(col)
    begin
      self[col] = rand(36**4)
    end while User.exists?(col => self[col])
  end
  
  def combine_contact_name
    if self.role == 'client'
      if !self.contact_name1.blank? and !self.contact_name2.blank?
        self.contact_name = self.contact_name1+" "+self.contact_name2
      end
    end
  end
  
end
