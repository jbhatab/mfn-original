class Event < ActiveRecord::Base
  has_event_calendar
  search_methods :region_search, :event_type_search
  
  has_many :events_users, :dependent => :destroy
  has_many :users, through: :events_users

  attr_accessible :address_attributes, :start_at, :end_at, :event_type, :festival_year_id
  
  belongs_to :festival_year
  has_many :rides, :dependent => :destroy
  accepts_nested_attributes_for :rides, :allow_destroy => true

  has_one :address, :as => :addressable, :dependent => :destroy
  accepts_nested_attributes_for :address, :allow_destroy => true
  

  self.per_page = 15

  scope :region_search,
    lambda {|region|
      includes(:address).where('LOWER(addresses.region) = ?', region.downcase)
    }

  scope :event_type_search,
    lambda {|type|
      where('LOWER(event_type) = ?', type.downcase)
    }
 
end
