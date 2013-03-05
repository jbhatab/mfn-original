class Ride < ActiveRecord::Base
  attr_accessible :address, :city, :cost, :giving_ride, :gmaps, :latitude, :leave_date, :longitude, :return_date, :state, :user_id
  belongs_to :festival
  belongs_to :user
  
end
