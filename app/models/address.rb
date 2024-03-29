class Address < ActiveRecord::Base
  acts_as_gmappable process_geocoding: lambda { |obj| obj.latitude.blank? && obj.longitude.blank? }
  attr_accessible :city, :country, :full_name, :line1, :line2, :state, :zip, :latitude, :longitude, :gmaps, :region, :addressable_id, :addressable_type
  belongs_to :addressable, :polymorphic => true

  validates_presence_of :state, :city

  def gmaps4rails_address
    "#{self.line1}, #{self.line2}, #{self.city}, #{self.state}, #{self.country}, #{self.zip} " 
  end
   

end