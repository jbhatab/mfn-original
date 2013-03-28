class Festival < ActiveRecord::Base
  acts_as_commentable

  attr_accessible :festival_years_attributes, :name, :website, :facebook, :img_url, :twitter
  
  has_many :festival_years, :dependent => :destroy
  accepts_nested_attributes_for :festival_years, :allow_destroy => true
  
  has_many :reviews

  validates_presence_of :name


  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      f =Festival.new(:name=>row[0], :website =>row[1], :facebook =>row[2], :img_url =>row[3])
      fy = f.festival_years.build(:year =>row[4])
      e = fy.events.build(:start_at =>row[5], :end_at =>row[6], :event_type =>row[7])
      a = e.build_address(:city =>row[8], :state =>row[9], :region =>row[10], :country =>row[11], :latitude =>row[12], :longitude =>row[13])
      f.save!
    end
  end

end
