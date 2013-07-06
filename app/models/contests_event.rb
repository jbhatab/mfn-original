class ContestsEvent < ActiveRecord::Base
  belongs_to :event
  belongs_to :contest
  # attr_accessible :title, :body
end
