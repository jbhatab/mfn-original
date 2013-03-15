class FestivalYear < ActiveRecord::Base
  attr_accessible :festival_year, :festival_id

  belongs_to :festival

  has_many :events, :dependent => :destroy

end
