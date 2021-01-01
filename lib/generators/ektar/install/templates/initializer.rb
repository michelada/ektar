# typed: ignore
Ektar.configure do |config|
  config.title = "My Application"
  config.session_name = "_remember_me"
  config.session_expiration = 3.days
  config.sign_in_path = "/signin"
  config.root_app_path = "/"
  config.rails_root = Rails.root
  config.session_domain = :all
end

