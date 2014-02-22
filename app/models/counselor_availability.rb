class CounselorAvailability < ActiveRecord::Base
  scope :between, lambda {|start_time, end_time|
    {:conditions => ["start_at BETWEEN '#{CounselorAvailability.format_date(start_time)}' AND '#{CounselorAvailability.format_date(end_time)}'"] }
  }
  attr_accessible :title,:start_at,:end_at,:counselor_id,:description
  belongs_to :counselor
  
  # need to override the json view to return what full_calendar is expecting.
  # http://arshaw.com/fullcalendar/docs/event_data/Event_Object/
  def as_json(options = {})
    {
      :id => self.id,
      :title => self.title+" by "+self.counselor.full_name,
      :start => start_at.rfc822,
      :end => end_at.rfc822,
      :allDay => 0,
      :recurring => false
      #      :url => '/'+self.counselor.class.to_s.downcase+'/dashboards'
    }

  end

  def self.format_date(date_time)
    Time.at(date_time.to_i).to_formatted_s(:db)
  end
end
