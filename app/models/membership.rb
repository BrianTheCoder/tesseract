class Membership < ActiveRecord::Base
  belongs_to :project
  belongs_to :account
  belongs_to :user
end
