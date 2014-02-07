class IntakeForm < ActiveRecord::Base
  attr_accessible :intake_type,:intake_status,:user_id
  belongs_to :user
  has_one :counseling,:dependent => :destroy
  has_one :medical,:dependent => :destroy
  has_one :personal,:dependent => :destroy
  has_many :client_availabilities,:dependent => :destroy
  has_one :reduced_fee,:dependent => :destroy
  has_one :minor,:dependent => :destroy
  has_many :notes, :as => :notable
  has_one :case
  has_many :documents
  has_many :appointments,:dependent => :destroy
  has_many :case_intake_forms,:dependent => :destroy
  def self.all_information(intake_id)
    @intake_form = IntakeForm.find(intake_id)
    if @intake_form.intake_type != 'financial' or @intake_form.intake_type != "reduced_fee"
      joins("left join counselings on counselings.intake_form_id = intake_forms.id").joins("left join users on users.id = intake_forms.user_id").joins("left join personals on personals.intake_form_id = intake_forms.id").where("intake_forms.id = #{intake_id}").select("intake_forms .*,concat(users.first_name,' ',users.last_name) as name,users.address as address,users.city as city,users.state as state,users.zipcode as zip,users.gender as gender,users.date_of_birth as date_of_birth,users.contact_name as contact_name,users.contact_phone as contact_no,users.relationship as relationship,users.contact_email as contact_email,personals.date_of_marriage as date_of_marriage,personals.marital_status as marital_status,personals.living_with as living_with,personals.occupation as occupation,personals.employer as employer,personals.time_with_current_emp as time_with_current_emp,personals.believe_in_god as believe_in_god,personals.religious_preference as religious_preference,personals.current_church as current_church,personals.member_of_redeemer_church as member_of_redeemer_church,personals.day_to_day_activity as day_to_day_activity")
    end
  end
end
