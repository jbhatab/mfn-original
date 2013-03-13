class Ride < ActiveRecord::Base
  acts_as_gmappable :validation => true
  attr_accessible :address, :city, :cost, :festival_id, :giving_ride, :gmaps, :latitude, :leave_date, :longitude, :return_date, :state, :user_id, :zip, :message
  belongs_to :festival
  belongs_to :user

  validates_presence_of :user_id, :festival_id
  
  def gmaps4rails_address
    "#{self.address}, #{self.city}, #{self.state}" 
  end


end
