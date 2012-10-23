require 'carrierwave/orm/activerecord'

class Image < ActiveRecord::Base
  attr_accessible :file
  
  validates :file, :user_id, :project_id, presence: true
  
  mount_uploader :file, ImageUploader
  
  belongs_to :user
  belongs_to :project
  
  has_many :regions
end
