class Event < ActiveRecord::Base
  has_event_calendar

  
  has_many :events_users, :dependent => :destroy
  has_many :users, through: :events_users

  attr_accessible :address_attributes, :start_at, :end_at, :event_type, :festival_year_id
  
  belongs_to :festival_year
  has_many :rides, :dependent => :destroy
  accepts_nested_attributes_for :rides, :allow_destroy => true

  has_one :address, :as => :addressable, :dependent => :destroy
  accepts_nested_attributes_for :address, :allow_destroy => true
  

  self.per_page = 15

  def self.search(search)
    if search
      where('lower(festivals.name) LIKE ?', "%#{search}%".downcase)
    else
      scoped
    end
  end

end
