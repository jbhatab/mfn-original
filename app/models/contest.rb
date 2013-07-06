class Contest < ActiveRecord::Base
  attr_accessible :description, :end_date, :title, :event_ids

  has_many :contests_users, :dependent => :destroy
  has_many :users, through: :contests_users


  has_many :contests_events, :dependent => :destroy
  has_many :events, through: :contests_events

end
