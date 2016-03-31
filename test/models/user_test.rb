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
    assert_equal ["Chrome", "Safari", "Safari", "Aetscape", "Mozilla"], browser
  end

  def test_user_returns_breakdown_of_os
    create_payloads

    os = User.os_breakdown

    assert os.any? { |b| b == "Macintosh" }
    assert os.any? { |b| b == "Macintosh" }
    assert os.any? { |b| b == "Linux" }
    assert os.any? { |b| b == "Windows" }
    assert_equal ["Macintosh", "Linux", "Windows", "Macintosh", "Macintosh"], os
  end

  def test_user_will_return_one_browser_for_single_payload
    PayloadRequest.create({ url_id: Url.create(address: "http://jumpstartlab.com/").id,
                            requested_at: "2013-02-16 21:38:28 -0700",
                            responded_in: 37,
                            referrer_id: Referrer.create(referred_by:"http://jumpstartlab.com").id,
                            request_type_id: RequestType.create(verb: "GET").id,
                            event_name: "socialLogin",
                            user_id: User.create(browser: UserAgent.parse("Mozilla/5.0 (Macintosh;) AppleWebKit/537.17 Safari/537.17").browser,
                                                 os: UserAgent.parse("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17").platform
                                                 ).id,
                            display_id: Display.create(width: "1920", height: "1280").id,
                            ip: "63.29.38.211"
                          })

    browser = User.browser_breakdown

    assert_equal ["Safari"], browser
  end

  def test_user_will_return_mozilla_for_empty_string_responses
    PayloadRequest.create({ url_id: Url.create(address: "http://jumpstartlab.com/").id,
                            requested_at: "2013-02-16 21:38:28 -0700",
                            responded_in: 37,
                            referrer_id: Referrer.create(referred_by:"http://jumpstartlab.com").id,
                            request_type_id: RequestType.create(verb: "GET").id,
                            event_name: "socialLogin",
                            user_id: User.create(browser: UserAgent.parse("").browser,
                                                 os: UserAgent.parse("").platform
                                                 ).id,
                            display_id: Display.create(width: "1920", height: "1280").id,
                            ip: "63.29.38.211"
                          })

    browser = User.browser_breakdown

    assert_equal ["Mozilla"], browser
  end

end
