class Festival < ActiveRecord::Base
  attr_accessible :city, :date, :genre, :lat, :long, :name, :state, :website
  has_many :lineups
  has_many :comments
  has_many :users, through: :lineups
end
