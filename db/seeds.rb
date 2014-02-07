# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(:first_name => 'Neeraj',:last_name => 'Chowdary',:email => 'admin@rcms-app.com',:password => 'qawsed!@#',:password_confirmation => 'qawsed!@#',:role => 'admin',:confirmation_token => nil,:confirmed_at => Time.now,:type => 'Administrator')
user = User.new(:first_name => 'Neeraj',:last_name => 'Chowdary',:email => 'client@rcms-app.com',:password => 'qawsed!@#',:password_confirmation => 'qawsed!@#',:role => 'client',:confirmation_token => nil,:confirmed_at => Time.now,:type => 'Client')
user.save(:validate => false)
User.create(:first_name => 'Neeraj',:last_name => 'Chowdary',:email => 'intake_coordinator@rcms-app.com',:password => 'qawsed!@#',:password_confirmation => 'qawsed!@#',:role => 'intake_coordinator',:confirmation_token => nil,:confirmed_at => Time.now,:type => 'IntakeCoordinator')
User.create(:first_name => 'Neeraj',:last_name => 'Chowdary',:email => 'counselor@rcms-app.com',:password => 'qawsed!@#',:password_confirmation => 'qawsed!@#',:role => 'counselor',:confirmation_token => nil,:confirmed_at => Time.now,:type => 'Counselor')
