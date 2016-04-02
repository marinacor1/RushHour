require_relative "../test_helper"

class DisplayTest < Minitest::Spec
  include TestHelpers

  def test_display_returns_screen_resolutions_for_all_requests
    create_payloads

    resolutions = Display.screen_resolutions

    assert_equal Array, resolutions.class
    array = ["1920 x 1280", "120 x 180", "9000 x 9000", "4000 x 4000", "192 x 128", "120 x 1280", "190 x 123"]
    assert_equal array, resolutions
  end

  def test_display_does_not_have_duplicates
    create_payloads

    resolutions = Display.screen_resolutions

    assert_equal resolutions, resolutions.uniq
  end

  def test_display_really_does_not_have_duplicated
      PayloadRequest.create({ url_id: Url.find_or_create_by(address: "http://jumpstartlab.com/article").id,
                            requested_at: "2013-02-16 21:38:28 -0700",
                            responded_in: 37,
                            referrer_id: Referrer.find_or_create_by(referred_by:"http://askjeeves.com").id,
                            request_type_id: RequestType.find_or_create_by(verb: "GET").id,
                            event_name: "socialLogin",
                            user_id: User.find_or_create_by(browser: UserAgent.parse("Safari/537.17").browser,
                                                 os: UserAgent.parse("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17").platform
                                                 ).id,
                            display_id: Display.find_or_create_by(width: "1920", height: "1280").id,
                            ip: "63.29.38.211",
                            client_id: 1,
                            param: "21"
                          })

      PayloadRequest.create({ url_id: Url.find_or_create_by(address: "http://jumpstartlab.com/article").id,
                            requested_at: "2013-02-16 21:38:28 -0700",
                            responded_in: 37,
                            referrer_id: Referrer.find_or_create_by(referred_by:"http://askjeeves.com").id,
                            request_type_id: RequestType.find_or_create_by(verb: "GET").id,
                            event_name: "socialLogin",
                            user_id: User.find_or_create_by(browser: UserAgent.parse("Safari/537.17").browser,
                                                 os: UserAgent.parse("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17").platform
                                                 ).id,
                            display_id: Display.find_or_create_by(width: "1920", height: "1280").id,
                            ip: "63.29.38.211",
                            client_id: 1,
                            param: "25"
                          })

      assert_equal 1, Display.all.count
      resolutions = Display.screen_resolutions
      assert_equal resolutions, resolutions.uniq
  end


end
