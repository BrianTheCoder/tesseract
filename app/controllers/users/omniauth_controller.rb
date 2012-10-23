class Users::OmniauthController < Devise::OmniauthCallbacksController
  attr_accessor :provider
  
  def method_missing(provider)
    @provider = provider
    unless User.omniauth_providers.index(provider).blank?
      user_signed_in? ? add_service : create_user
    end
  end
    
  def add_service
    unless current_user.services.by_service(omniauth['provider'], omniauth['uid']).exists?
      service = Service.from_omniauth(omniauth)
      current_user.services << service
      current_user.save
    end
    redirect_to edit_user_registration_path
  end
  
  def create_user
    service = Service.by_service(omniauth['provider'], omniauth['uid']).first
    if service.present?
      sign_in(service.user)
      redirect_to goals_path
    else
      @user = User.new
      @user.apply_omniauth(omniauth)
      if @user.save
        sign_in(@user)
        redirect_to goals_path
      else
        redirect_to new_user_registration_url
      end
    end
  end
  
  def omniauth
    @omniauth ||= env['omniauth.auth']
  end
end