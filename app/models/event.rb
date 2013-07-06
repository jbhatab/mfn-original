class Event < ActiveRecord::Base

  acts_as_gmappable process_geocoding: lambda { |obj| obj.address.latitude.blank? && obj.address.longitude.blank? }

  def latitude
    address.latitude
  end

  def longitude
    address.longitude
  end

  has_event_calendar
  search_methods :region_search, :event_type_search
  
  has_many :events_users, :dependent => :destroy
  has_many :users, through: :events_users

  has_many :contests_events, :dependent => :destroy
  has_many :contests, through: :contests_events

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
 

  def gmaps4rails_address
    "#{self.address.line1}, #{self.address.line2}, #{self.address.city}, #{self.address.state}, #{self.address.country}, #{self.address.zip} " 
  end

end
