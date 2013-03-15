class Address < ActiveRecord::Base
  acts_as_gmappable
  attr_accessible :city, :country, :full_name, :line1, :line2, :state, :zip, :latitude, :longitude, :gmaps
  belongs_to :addressable, :polymorphic => true

  def gmaps4rails_address
    "#{self.line1}, #{self.line2}, #{self.city}, #{self.state}, #{self.country}, #{self.zip}, #{self.latitude}, #{self.longitude} " 
  end

end
