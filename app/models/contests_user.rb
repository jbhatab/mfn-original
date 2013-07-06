class ContestsUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :contest
  # attr_accessible :title, :body
end
