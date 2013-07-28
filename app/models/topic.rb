class Topic < ActiveRecord::Base
  belongs_to :user
  belongs_to :forum
  attr_accessible :forum_id, :last_poster_id, :last_post_at, :name, :user_id

  has_many :posts, :dependent => :destroy  
end
