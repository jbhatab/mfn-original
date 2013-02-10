class Event < ActiveRecord::Base
  has_event_calendar
  has_one :festival
  attr_accessible :name, :festival_id, :start_at, :end_at
  validates_presence_of :start_at, :end_at
end
