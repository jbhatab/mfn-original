class Comment < ActiveRecord::Base

  include ActsAsCommentable::Comment
  attr_accessible :comment, :title
  belongs_to :commentable, :polymorphic => true

  default_scope :order => 'created_at ASC'
  acts_as_votable
  #validates_presence_of :username
  #validates_uniqueness_of :username
  # NOTE: install the acts_as_votable plugin if you
  # want user to vote on the quality of comments.
  #acts_as_voteable

  # NOTE: Comments belong to a user
  belongs_to :user
end
