class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :token_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
         
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name
  
  serialize :billing_info
  
  has_many :memberships
  has_many :projects, through: :memberships
  has_many :images
  has_many :regions
  has_one :account
  
  def name=(str)
    self.first_name, self.last_name = str.split
  end
  
  def name
    "#{first_name} #{last_name}"
  end
  
  def admin?
    account.present?
  end
  
  def apply_omniauth(omniauth)
    unless omniauth['credentials'].blank?
      service = Service.from_omniauth(omniauth)
      self.services << service
      self.name = service.name if name.blank?
      self.email = service.email if email.blank?
      self.password = Devise.friendly_token if password.blank? || password_confirmation.blank?
    end
  end
  
  def all_time_points
    points.sum(:amount)
  end
  
  def award_points_for(task)
    points.build.tap do |point|
      point.task_description = task.description
      point.goal_title = task.goal.title
      point.amount = task.weight
      point.goal = task.goal
      point.save
    end
    self.point_total += task.weight
    save
  end
  
  def update_billing!(info)
    info['customer_id'].blank? ? create_billing(info) : refresh_billing(info)
    save
  end
  
  def create_billing(info)
    customer = Stripe::Customer.create({
      card: info[:token],
      plan: 'pro',
      email: email
    })
    info['customer_id'] = customer.id
    self.billing_info = info
  end
  
  def refresh_billing(info)
    customer = Stripe::Customer.retrieve(billing_info['customer_id'])
    customer.card = info[:token]
    customer.save
    self.billing_info['customer_id'] = customer.id
  end
  
  def cancel_billing!
    customer = Stripe::Customer.retrieve(billing_info['customer_id'])
    customer.delete
    self.billing_info = {}
    save
  end
end
