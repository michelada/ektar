# typed: ignore
module LoginHelper
  COOKIE_NAME = "_dummy_remember_me"

  def current_user
    @current_user ||= ektar_users(:user)
  end

  def sign_in(user)
    my_cookies = ActionDispatch::Request.new(Rails.application.env_config.deep_dup).cookie_jar
    my_cookies.encrypted[COOKIE_NAME] = {
      value: {
        user: user.global_id,
        organization: user.memberships.first.organization.global_id
      },
      expires: 1.day.from_now
    }
    cookies[COOKIE_NAME] = my_cookies[COOKIE_NAME]
  end
end
