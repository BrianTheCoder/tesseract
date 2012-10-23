Devise.setup do |config|
  config.mailer_sender = "please-change-me-at-config-initializers-devise@example.com"
  require 'devise/orm/active_record'
  config.case_insensitive_keys = [ :email ]
  config.strip_whitespace_keys = [ :email ]
  config.skip_session_storage = [:http_auth]
  config.stretches = Rails.env.test? ? 1 : 10
  config.pepper = "b7e5f04fcb3346f45cb3fc1a5c02615b90c661e8292a0c2471dd22c76b633b345ceba4616be3b05c1276c9fc9bf65a5c242b0627b263cc25337f4fb43ddc33df"
  config.remember_for = 6.weeks
  config.extend_remember_period = true
  config.reset_password_within = 1.day
  config.sign_out_via = :delete
  config.omniauth :github, Tesseract::SiteConfig['github']['id'], Tesseract::SiteConfig['github']['secret']
end