class Region < ActiveRecord::Base
  attr_accessible :identifier, :x, :y, :width, :height
  
  belongs_to :user
  belongs_to :image
end
