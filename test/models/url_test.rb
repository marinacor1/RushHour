require_relative "../test_helper"

class UrlTest < Minitest::Spec
  include TestHelpers

  def test_duplicate_urls_are_eliminated
    single_payload
    single_payload

    all_sites = Url.all
    assert_equal 1, all_sites.count
  end

  def test_returns_max_response_time_by_url
    create_payloads

    url = Url.find_by(address: "http://jumpstartlab.com/")

    assert_equal 37, url.max_response_time
  end

  def test_returns_min_response_time_by_url
    create_payloads

    url = Url.find_by(address: "http://turing.io/")
    assert_equal 10, url.min_response_time
  end

  def test_can_list_ordered_response_times_by_url
    create_payloads

    url = Url.find_by(address: "http://turing.io/")

    assert_equal [100, 100, 100, 90, 10], url.sorted_response_times
  end

  def test_can_list_ordered_response_times_with_different_url
    create_payloads

    url = Url.find_by(address: "http://jumpstartlab.com/")

    assert_equal [37, 37, 37, 37, 37, 37, 37, 37, 7], url.sorted_response_times
  end

  def test_can_find_avg_for_all_response_times_by_url
    create_payloads

    url = Url.find_by(address: "http://turing.io/")

    assert_equal 80.0, url.average_response_time
  end

  def test_can_find_avg_for_all_responses_with_diff_url
    create_payloads

    url = Url.find_by(address: "http://jumpstartlab.com/")

    assert_equal 33.67, url.average_response_time
  end

  def test_can_find_http_verbs_by_url
    create_payloads

    url = Url.find_by(address: "http://turing.io/")
    assert_equal ["POST", "PUT", "POST", "POST", "POST"], url.all_verbs
  end

  def test_can_find_http_verbs_with_different_url
    create_payloads

    url = Url.find_by(address: "http://yahoo.com/")
    assert_equal ["DELETE"], url.all_verbs
  end

  def test_can_find_three_most_popular_referrers
    skip
    create_payloads

    url = Url.find_by(address: "http://jumpstartlab.com/")

    sorted_referrers = url.popular_referrers

    assert_equal "http://google.com", sorted_referrers[1]
    assert_equal "http://jumpstartlab.com", sorted_referrers.first
    assert_equal 3, sorted_referrers.count
  end

  def test_returns_one_referrer_if_only_one_option_in_payloads
    single_turing_payload
    single_turing_payload
    single_turing_payload

    url = Url.find_by(address: "http://turing.io/")

    sorted_referrers = url.popular_referrers

    assert_equal ["http://google.com"], sorted_referrers
  end

  def test_returns_single_referrer_if_single_payload_given
    single_payload

    url = Url.find_by(address: "http://jumpstartlab.com/")

    sorted_referrers = url.popular_referrers

    assert_equal ["http://jumpstartlab.com"], sorted_referrers

  end

  def test_can_find_three_most_popular_user_agents
    create_payloads
    single_payload

    url = Url.find_by(address: "http://jumpstartlab.com/")

    user_agents = url.popular_user_agents

    assert_equal [[["Macintosh", "Safari"]], [["Macintosh", "Chrome"]], [["Windows", "Intel"]]], user_agents
  end

  def test_returns_single_user_agent_if_only_one_popular_option
   single_turing_payload
   single_turing_payload
   single_turing_payload

    url = Url.find_by(address: "http://turing.io/")

    user_agents = url.popular_user_agents

    assert_equal [[["Macintosh", "Chrome"]]], user_agents
    assert_equal 1, user_agents.count
  end

  def test_returns_single_user_agent_if_only_one_payload
    single_payload

    url = Url.find_by(address: "http://jumpstartlab.com/")

    user_agents = url.popular_user_agents

    assert_equal [[["Macintosh", "Chrome"]]], user_agents
    assert_equal 1, user_agents.count
  end

  def test_url_can_return_relative_path
    client = Client.create(identifier: 'jumpstartlab', root_url: 'http://jumpstartlab.com')
    PayloadRequest.create({ url_id: Url.find_or_create_by(address: "http://jumpstartlab.com/blog/1").id,
                            requested_at: "2013-02-16 21:38:28 -0700",
                            responded_in: 7,
                            referrer_id: Referrer.find_or_create_by(referred_by:"http://jumpstartlab.com").id,
                            request_type_id: RequestType.find_or_create_by(verb: "POST").id,
                            event_name: "socialLogin",
                            user_id: User.find_or_create_by(browser: UserAgent.parse("Aetscape/5.0 (Macintosh; Intel Mac OS X 10_8_2) Aetscape/537.17 (KHTML, like Gecko) Aetscape/24.0.1309.0 Aetscape/537.17").browser,
                                                 os: UserAgent.parse("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17").platform
                                                 ).id,
                            client_id: client.id,
                            display_id: Display.find_or_create_by(width: "1920", height: "1280").id,
                            ip: "63.29.38.211",
                            param: "15"
                          })
    url = Url.find_or_create_by(address: "http://jumpstartlab.com/blog/1")

    assert_equal "blog/1", url.find_relative_path
  end
end
