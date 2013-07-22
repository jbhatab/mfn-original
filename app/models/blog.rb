class Blog < ActiveRecord::Base
  acts_as_commentable
  attr_accessible :content, :title, :author
  belongs_to :user

  self.per_page = 3

  validates_presence_of :content, :title, :author
end
