class Invite < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :user
  belongs_to :project
  belongs_to :invited_by, class_name: 'User'
end
