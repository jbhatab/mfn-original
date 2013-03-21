class Review < ActiveRecord::Base
  attr_accessible :rating, :security, :title, :content, :atmosphere, :music, :staging, :vendors, :amenities, :vip, :parking, :year
  belongs_to :user
  belongs_to :festival
  acts_as_votable
end
