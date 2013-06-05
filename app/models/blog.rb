class Blog < ActiveRecord::Base
  attr_accessible :content, :title, :cover
  belongs_to :user
end
