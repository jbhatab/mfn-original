class Event < ActiveRecord::Base
  has_event_calendar

  
  
  has_many :events_users, :dependent => :destroy
  has_many :users, through: :events_users

  attr_accessible :start_at, :end_at, :event_type, :festival_year_id
  
  belongs_to :festival_year
  has_many :rides, :dependent => :destroy
  accepts_nested_attributes_for :rides

  has_one :address, :as => :addressable
  accepts_nested_attributes_for :address
  

end
