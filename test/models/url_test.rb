require_relative "../test_helper"

class UrlTest < Minitest::Spec
  include TestHelpers

  def setup
    create_payloads
  end

  def test_duplicate_urls_are_eliminated
    assert_equal 3, Url.all.count
  end

#TODO should this responsibility lie in payload class?

  def test_can_list_urls_by_num_times_requested
    url_list = Url.sort_url_requests
    assert_equal "http://jumpstartlab.com/", url_list[0]

    assert_equal 3, url_list.count
    assert url_list.include?("http://turing.io/")
    assert url_list.include?("http://yahoo.com/")
  end

  def test_returns_max_response_time_by_url
    url = Url.find_by(address: "http://jumpstartlab.com/")
    assert_equal 37, Url.max_response_time(url)
  end

  def test_returns_min_response_time_by_url
    PayloadRequest.create({ url_id: Url.find_or_create_by(address: "http://turing.io/").id,
                            requested_at: "2014-02-16 21:38:28 -0700",
                            responded_in: 10,
                            referrer_id: Referrer.find_or_create_by(referred_by:"http://google.com").id,
                            request_type_id: RequestType.find_or_create_by(verb: "POST").id,
                            event_name: "passwordEntry",
                            user_id: User.find_or_create_by(browser: UserAgent.parse("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Opera/24.0.1309.0 Safari/537.17").browser,
                                                 os: UserAgent.parse("Mozilla/5.0 (Linux; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17").platform
                                                 ).id,
                            display_id: Display.find_or_create_by(width: "9000", height: "9000").id,
                            ip: "99.99.99.9999"
                          })

    url = Url.find_by(address: "http://turing.io/")
    assert_equal 10, Url.min_response_time(url)
  end

  def test_can_list_ordered_response_times_by_url
    PayloadRequest.create({ url_id: Url.find_or_create_by(address: "http://turing.io/").id,
                            requested_at: "2014-02-16 21:38:28 -0700",
                            responded_in: 100,
                            referrer_id: Referrer.find_or_create_by(referred_by:"http://google.com").id,
                            request_type_id: RequestType.find_or_create_by(verb: "POST").id,
                            event_name: "passwordEntry",
                            user_id: User.find_or_create_by(browser: UserAgent.parse("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Opera/24.0.1309.0 Safari/537.17").browser,
                                                 os: UserAgent.parse("Mozilla/5.0 (Linux; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17").platform
                                                 ).id,
                            display_id: Display.find_or_create_by(width: "9000", height: "9000").id,
                            ip: "99.99.99.9999"
                          })

    url = Url.find_by(address: "http://turing.io/")

    sorted_response_times = Url.sorted_response_times(url)

    assert_equal [100, 90], sorted_response_times
  end

  def test_can_find_avg_for_all_response_times_by_url
    PayloadRequest.create({ url_id: Url.find_or_create_by(address: "http://turing.io/").id,
                            requested_at: "2014-02-16 21:38:28 -0700",
                            responded_in: 100,
                            referrer_id: Referrer.find_or_create_by(referred_by:"http://google.com").id,
                            request_type_id: RequestType.find_or_create_by(verb: "POST").id,
                            event_name: "passwordEntry",
                            user_id: User.find_or_create_by(browser: UserAgent.parse("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Opera/24.0.1309.0 Safari/537.17").browser,
                                                 os: UserAgent.parse("Mozilla/5.0 (Linux; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17").platform
                                                 ).id,
                            display_id: Display.find_or_create_by(width: "9000", height: "9000").id,
                            ip: "99.99.99.9999"
                          })

    url = Url.find_by(address: "http://turing.io/")

    assert_equal 95, Url.average_response_time(url)
  end

  def test_can_find_http_verbs_by_url
    PayloadRequest.create({ url_id: Url.find_or_create_by(address: "http://turing.io/").id,
                            requested_at: "2014-02-16 21:38:28 -0700",
                            responded_in: 100,
                            referrer_id: Referrer.find_or_create_by(referred_by:"http://google.com").id,
                            request_type_id: RequestType.find_or_create_by(verb: "PUT").id,
                            event_name: "passwordEntry",
                            user_id: User.find_or_create_by(browser: UserAgent.parse("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Opera/24.0.1309.0 Safari/537.17").browser,
                                                 os: UserAgent.parse("Mozilla/5.0 (Linux; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17").platform
                                                 ).id,
                            display_id: Display.find_or_create_by(width: "9000", height: "9000").id,
                            ip: "99.99.99.9999"
                          })

    url = Url.find_by(address: "http://turing.io/")

    assert_equal ["POST", "PUT"], Url.all_verbs(url)
  end

  def test_can_find_three_most_popular_referrers
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

    url = Url.find_by(address: "http://jumpstartlab.com/")

    sorted_referrers = Url.popular_referrers(url)

    assert_equal ["http://jumpstartlab.com", "http://google.com", "http://bing.com"], sorted_referrers
  end

  def test_can_find_three_most_popular_user_agents
    PayloadRequest.create({ url_id: Url.find_or_create_by(address: "http://jumpstartlab.com/").id,
                            requested_at: "2013-02-16 21:38:28 -0700",
                            responded_in: 37,
                            referrer_id: Referrer.find_or_create_by(referred_by:"http://jumpstartlab.com").id,
                            request_type_id: RequestType.find_or_create_by(verb: "GET").id,
                            event_name: "socialLogin",
                            user_id: User.find_or_create_by(browser: UserAgent.parse("Aetscape/5.0 (Macintosh; Intel Mac OS X 10_8_2) Aetscape/537.17 (KHTML, like Gecko) Aetscape/24.0.1309.0 Aetscape/537.17").browser,
                                                 os: UserAgent.parse("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17").platform
                                                 ).id,
                            display_id: Display.find_or_create_by(width: "1920", height: "1280").id,
                            ip: "63.29.38.211"
                          })

    PayloadRequest.create({ url_id: Url.find_or_create_by(address: "http://jumpstartlab.com/").id,
                            requested_at: "2013-02-16 21:38:28 -0700",
                            responded_in: 37,
                            referrer_id: Referrer.find_or_create_by(referred_by:"http://jumpstartlab.com").id,
                            request_type_id: RequestType.find_or_create_by(verb: "GET").id,
                            event_name: "socialLogin",
                            user_id: User.find_or_create_by(browser: UserAgent.parse("").browser,
                                                 os: UserAgent.parse("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17").platform
                                                 ).id,
                            display_id: Display.find_or_create_by(width: "1920", height: "1280").id,
                            ip: "63.29.38.211"
                          })


    url = Url.find_by(address: "http://jumpstartlab.com/")

    user_agents = Url.popular_user_agents(url)

    assert_equal [["Macintosh", "Chrome"], ["Macintosh", "Mozilla"], ["Macintosh", "Aetscape"]], user_agents
    assert_equal 3, user_agents.count
  end

end
