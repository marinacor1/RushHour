require_relative "../test_helper"

class UrlTest < Minitest::Spec
  include TestHelpers

  def setup
    create_payloads
  end

  def test_duplicate_urls_are_eliminated
    assert_equal 3, Url.all.count
  end

  def test_can_list_urls_by_num_times_requested
    skip
    url_list = Url.sort_url_requests
    assert_equal "http://yahoo.com/", url_list[0][0]
    assert_equal "http://turing.io", url_list[1][0]
    assert_equal "http://jumpstartlab.com/", url_list[2][0]
    assert_equal 3, url_list.count
  end

  def test_returns_max_response_time_by_url
    url = Url.find_by(address: "http://jumpstartlab.com/")
    assert_equal 37, Url.max_response_time(url)
  end

  def test_returns_min_response_time_by_url
    PayloadRequest.create({ url_id: Url.find_or_create_by(address: "http://turing.io/").id,
                            requested_at: "2014-02-16 21:38:28 -0700",
                            responded_in: 10,
                            referrer_id: Referrer.create(referred_by:"http://google.com").id,
                            request_type_id: RequestType.create(verb: "POST").id,
                            event_name: "passwordEntry",
                            user_id: User.create(browser: UserAgent.parse("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Opera/24.0.1309.0 Safari/537.17").browser,
                                                 os: UserAgent.parse("Mozilla/5.0 (Linux; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17").platform
                                                 ).id,
                            display_id: Display.create(width: "9000", height: "9000").id,
                            ip: "99.99.99.9999"
                          })

    url = Url.find_by(address: "http://turing.io/")
    assert_equal 10, Url.min_response_time(url)
  end

  def test_can_list_ordered_response_times_by_url
    PayloadRequest.create({ url_id: Url.find_or_create_by(address: "http://turing.io/").id,
                            requested_at: "2014-02-16 21:38:28 -0700",
                            responded_in: 100,
                            referrer_id: Referrer.create(referred_by:"http://google.com").id,
                            request_type_id: RequestType.create(verb: "POST").id,
                            event_name: "passwordEntry",
                            user_id: User.create(browser: UserAgent.parse("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Opera/24.0.1309.0 Safari/537.17").browser,
                                                 os: UserAgent.parse("Mozilla/5.0 (Linux; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17").platform
                                                 ).id,
                            display_id: Display.create(width: "9000", height: "9000").id,
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
                            referrer_id: Referrer.create(referred_by:"http://google.com").id,
                            request_type_id: RequestType.create(verb: "POST").id,
                            event_name: "passwordEntry",
                            user_id: User.create(browser: UserAgent.parse("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Opera/24.0.1309.0 Safari/537.17").browser,
                                                 os: UserAgent.parse("Mozilla/5.0 (Linux; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17").platform
                                                 ).id,
                            display_id: Display.create(width: "9000", height: "9000").id,
                            ip: "99.99.99.9999"
                          })

    url = Url.find_by(address: "http://turing.io/")

    assert_equal 95, Url.average_response_time(url)
  end

  def test_can_find_http_verbs_by_url
    PayloadRequest.create({ url_id: Url.find_or_create_by(address: "http://turing.io/").id,
                            requested_at: "2014-02-16 21:38:28 -0700",
                            responded_in: 100,
                            referrer_id: Referrer.create(referred_by:"http://google.com").id,
                            request_type_id: RequestType.create(verb: "PUT").id,
                            event_name: "passwordEntry",
                            user_id: User.create(browser: UserAgent.parse("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Opera/24.0.1309.0 Safari/537.17").browser,
                                                 os: UserAgent.parse("Mozilla/5.0 (Linux; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17").platform
                                                 ).id,
                            display_id: Display.create(width: "9000", height: "9000").id,
                            ip: "99.99.99.9999"
                          })

    url = Url.find_by(address: "http://turing.io/")

    assert_equal ["POST", "PUT"], Url.all_verbs(url)

  end

end
