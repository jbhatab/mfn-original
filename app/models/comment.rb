class Comment < ActiveRecord::Base

  include ActsAsCommentable::Comment
  attr_accessible :comment, :title
  belongs_to :commentable, :polymorphic => true

  default_scope :order => 'created_at ASC'
  acts_as_votable

  # NOTE: Comments belong to a user
  belongs_to :user
end
