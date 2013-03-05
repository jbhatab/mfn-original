class Event < ActiveRecord::Base
  has_event_calendar
  attr_accessible :name, :festival_id, :start_at, :end_at
  validates_presence_of :start_at, :end_at, :festival_id
  validates_uniqueness_of :festival_id
  belongs_to :festival
end
