class Service < ActiveRecord::Base
  attr_accessible :provider, :uid, :info, :credentials
  
  serialize :info
  serialize :credentials
  
  belongs_to :user
  
  def self.by_service(provider, uid)
    where(provider: provider, uid: uid)
  end
  
  def self.from_omniauth(auth)
    new({
      uid: auth['uid'],
      provider: auth['provider'],
      info: auth['info'],
      credentials: auth['credentials'],
    })
  end
  
  def username
    info['nickname']
  end
  
  def email
    info['email']
  end
  
  def name
    info['name']
  end
  
  def avatar
    case provider
    when 'facebook'
      "https://graph.facebook.com/#{uid}/picture"
    end
  end
end
