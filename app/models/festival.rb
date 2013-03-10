class Festival < ActiveRecord::Base
  acts_as_commentable
  has_event_calendar :start_at_field  => 'start_date', :end_at_field => 'end_date'
  acts_as_gmappable :process_geocoding => false
  attr_accessible :zip, :address, :city, :start_date, :end_date, :festivaltype, :latitude, :longitude, :name, :state, :website, :facebook, :region, :img_url, :lg_img_url
  has_many :lineups, :dependent => :destroy
  has_many :rides, :dependent => :destroy
  accepts_nested_attributes_for :rides

  def location
    [:latitude, :longitude]
  end
  has_many :users, through: :lineups

  self.per_page = 12

  def self.search(search)
    if search
      where('name LIKE ?', "%#{search}%")
    else
      scoped
    end
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      f =Festival.create(:name=>row[0], :city =>row[1], :state =>row[2], :latitude =>row[3], :longitude =>row[4], :start_date =>row[5], :end_date =>row[6], :website =>row[7], :region =>row[8], :festivaltype =>row[9], :facebook =>row[10], :img_url =>row[11], :lg_img_url =>row[12])
      Event.create(:name =>f.name, :festival_id=>f.id, :start_at=>f.start_date, :end_at=>f.end_date)
    end
  end
end
