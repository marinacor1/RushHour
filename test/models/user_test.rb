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

  def test_user_returns_breakdown_of_os
    create_payloads

    browser = User.os_breakdown

    assert browser.any? { |b| b == "Macintosh" }
    assert browser.any? { |b| b == "Macintosh" }
    assert browser.any? { |b| b == "Linux" }
    assert browser.any? { |b| b == "Windows" }

  end

end
