class Festival < ActiveRecord::Base
  acts_as_commentable
  attr_accessible :zip, :address, :city, :start_date, :end_date, :festivaltype, :lat, :long, :name, :state, :website, :facebook, :region, :img_url, :lg_img_url
  has_many :lineups
  has_many :events
  has_many :users, through: :lineups


  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      f =Festival.create(:name=>row[0], :city =>row[1], :state =>row[2], :lat =>row[3], :long =>row[4], :start_date =>row[5], :end_date =>row[6], :website =>row[7], :region =>row[8], :festivaltype =>row[9], :facebook =>row[10], :img_url =>row[11], :lg_img_url =>row[12])
      Event.create(:name =>f.name, :festival_id=>f.id, :start_at=>f.start_date, :end_at=>f.end_date)
    end
  end
end
