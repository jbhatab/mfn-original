class Festival < ActiveRecord::Base
  acts_as_commentable

  attr_accessible :name, :website, :facebook, :img_url, :twitter
  
  has_many :festival_years
  accepts_nested_attributes_for :festival_years
  
  
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
    end
  end

end
