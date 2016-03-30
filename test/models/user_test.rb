require_relative "../test_helper"

class UserTest < Minitest::Spec
  include TestHelpers

  def test_user_returns_breakdown_of_web_browser
    create_payloads

    browser = User.browser_breakdown

    assert browser.any? { |b| b == "Chrome" }
    assert browser.any? { |b| b == "Chrome" }
    assert browser.any? { |b| b == "Safari" }
    assert browser.any? { |b| b == "Safari" }
  end

end
