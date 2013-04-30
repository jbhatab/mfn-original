class FestivalYear < ActiveRecord::Base
  attr_accessible :events_attributes, :year, :festival_id

  belongs_to :festival

  has_many :events, :dependent => :destroy
  accepts_nested_attributes_for :events, :allow_destroy => true

end
