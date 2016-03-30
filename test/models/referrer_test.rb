require_relative "../test_helper"

class ReferrerTest < Minitest::Spec
  include TestHelpers

  def setup
    create_payloads
  end

  def test_lists_referrrers_in_order
    skip
      PayloadRequest.create({ url_id: Url.find_or_create_by(address: "http://jumpstartlab.com/").id,
                              requested_at: "2013-02-16 21:38:28 -0700",
                              responded_in: 37,
                              referrer_id: Referrer.find_or_create_by(referred_by:"http://jumpstartlab.com").id,
                              request_type_id: RequestType.find_or_create_by(verb: "GET").id,
                              event_name: "socialLogin",
                              user_id: User.find_or_create_by(browser: UserAgent.parse("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17").browser,
                                                   os: UserAgent.parse("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17").platform
                                                   ).id,
                              display_id: Display.find_or_create_by(width: "1920", height: "1280").id,
                              ip: "63.29.38.211"
                            })

      PayloadRequest.create({ url_id: Url.find_or_create_by(address: "http://jumpstartlab.com/").id,
                              requested_at: "2013-02-16 21:38:28 -0700",
                              responded_in: 37,
                              referrer_id: Referrer.find_or_create_by(referred_by:"http://google.com").id,
                              request_type_id: RequestType.find_or_create_by(verb: "GET").id,
                              event_name: "socialLogin",
                              user_id: User.find_or_create_by(browser: UserAgent.parse("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17").browser,
                                                   os: UserAgent.parse("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17").platform
                                                   ).id,
                              display_id: Display.find_or_create_by(width: "1920", height: "1280").id,
                              ip: "63.29.38.211"
                            })

      PayloadRequest.create({ url_id: Url.find_or_create_by(address: "http://jumpstartlab.com/").id,
                              requested_at: "2013-02-16 21:38:28 -0700",
                              responded_in: 37,
                              referrer_id: Referrer.find_or_create_by(referred_by:"http://google.com").id,
                              request_type_id: RequestType.find_or_create_by(verb: "GET").id,
                              event_name: "socialLogin",
                              user_id: User.find_or_create_by(browser: UserAgent.parse("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17").browser,
                                                   os: UserAgent.parse("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17").platform
                                                   ).id,
                              display_id: Display.find_or_create_by(width: "1920", height: "1280").id,
                              ip: "63.29.38.211"
                            })

      PayloadRequest.create({ url_id: Url.find_or_create_by(address: "http://jumpstartlab.com/").id,
                              requested_at: "2013-02-16 21:38:28 -0700",
                              responded_in: 37,
                              referrer_id: Referrer.find_or_create_by(referred_by:"http://bing.com").id,
                              request_type_id: RequestType.find_or_create_by(verb: "GET").id,
                              event_name: "socialLogin",
                              user_id: User.find_or_create_by(browser: UserAgent.parse("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17").browser,
                                                   os: UserAgent.parse("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17").platform
                                                   ).id,
                              display_id: Display.find_or_create_by(width: "1920", height: "1280").id,
                              ip: "63.29.38.211"
                            })

    assert_equal [], Referrer.list_referrers
  end

end
