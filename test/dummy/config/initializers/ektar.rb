# typed: ignore
Ektar.configure do |config|
  config.title = "Dummy Administration"
  config.organization_username = "manager"
  config.organization_password = "secrets"
  config.session_name = "_dummy"
  config.session_expiration = 1.days.from_now
end
