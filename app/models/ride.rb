class Ride < ActiveRecord::Base
  has_one :address, :as => :addressable
  attr_accessible :cost, :event_id, :giving_ride, :leave_date, :return_date, :user_id, :message
  belongs_to :event
  belongs_to :user

  validates_presence_of :user_id, :event_id

end
