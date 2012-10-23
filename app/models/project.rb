class Project < ActiveRecord::Base
  attr_accessible :title
  
  validates :title, presence: true
  
  belongs_to :account
    
  has_many :images
  has_many :regions
end
