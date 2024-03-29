class Ride < ActiveRecord::Base
  acts_as_commentable
  
  has_one :address, :as => :addressable, :dependent => :destroy
  accepts_nested_attributes_for :address, :allow_destroy => true
  attr_accessible :address_attributes, :cost, :event_id, :giving_ride, :leave_date, :return_date, :user_id, :message
  belongs_to :event
  belongs_to :user

  validates_presence_of :user_id, :event_id, :leave_date, :return_date, :giving_ride



end
