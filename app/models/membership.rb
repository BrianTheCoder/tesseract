class Membership < ActiveRecord::Base
  attr_accessible :name, :email
  
  belongs_to :project
  belongs_to :account
  belongs_to :user
  belongs_to :inviter, class_name: 'User'
  
  validates :email, uniqueness: [:project_id]
  
  before_validation :make_token
  before_save :set_user
  before_save :set_email_and_name
  
  def status
    if accepted_at.blank?
      :pending
    else
      :accepted
    end
  end
  
  protected
  
  def make_token
    self.token = Devise.friendly_token
  end
  
  def set_user
    self.user = User.where(email: email).first if user.blank?
  end
  
  def set_email_and_name
    if user.present?
      self.name = user.name
      self.email = user.email
    end
  end
end
