class Festival < ActiveRecord::Base
  acts_as_commentable

  attr_accessible :festival_years_attributes, :reviews_attributes, :name, :website, :facebook, :img_url, :twitter
  
  has_many :festival_years, :dependent => :destroy
  accepts_nested_attributes_for :festival_years, :allow_destroy => true
  
  has_many :reviews
  accepts_nested_attributes_for :reviews

  validates_presence_of :name


  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      f =Festival.new(:name=>row[0], :website =>row[1], :facebook =>row[2], :twitter =>row[3], :img_url =>row[4])
      fy = f.festival_years.build(:year =>row[5])
      e = fy.events.build(:start_at =>row[6], :end_at =>row[7], :event_type =>row[8])
      a = e.build_address(:city =>row[9], :state =>row[10], :region =>row[11], :country =>row[12], :latitude =>row[13], :longitude =>row[14])
      f.save!
    end
  end

end
