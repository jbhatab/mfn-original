class Festival < ActiveRecord::Base
  attr_accessible :city, :date, :genre, :lat, :long, :name, :state, :website
  acts_as_commentable
  has_many :lineups
  has_many :users, through: :lineups
end
