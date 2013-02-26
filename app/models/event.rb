class Event < ActiveRecord::Base
  has_event_calendar
  attr_accessible :name, :festival_id, :start_at, :end_at
  validates_presence_of :start_at, :end_at
  belongs_to :festival
end
