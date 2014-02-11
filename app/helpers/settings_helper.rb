module SettingsHelper
  
  def phone_no(ph)
    ph.blank? ? nil : ph[0..2]+"-"+ph[3..5]+"-"+ph[6..9]
  end
end
