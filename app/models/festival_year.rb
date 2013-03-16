class FestivalYear < ActiveRecord::Base
  attr_accessible :year, :festival_id

  belongs_to :festival

  has_many :events, :dependent => :destroy
  accepts_nested_attributes_for :events

end
