class Project < ActiveRecord::Base
  attr_accessible :title
  
  validates :title, presence: true
  
  belongs_to :account
    
  has_many :images, dependent: :destroy
  has_many :regions
  has_many :memberships
  
  def members
    User.find(memberships.select(:user_id).map(&:user_id))
  end
  
  def pending
    @_pending ||= memberships.where(accepted_at: nil).all
  end
end
