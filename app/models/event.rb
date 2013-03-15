class Event < ActiveRecord::Base
  has_event_calendar

  belongs_to :festival_year
  
  has_many :event_users, :dependent => :destroy
  has_many :users, through: :event_users

  attr_accessible :start_at, :end_at, :festival_year_id
  
  has_many :rides, :dependent => :destroy
  accepts_nested_attributes_for :rides

  has_one :address, :as => :addressable
  

  

end
