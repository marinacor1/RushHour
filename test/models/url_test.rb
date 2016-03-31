require_relative "../test_helper"

class UrlTest < Minitest::Spec
  include TestHelpers

  def test_duplicate_urls_are_eliminated
    single_payload
    single_payload

    all_sites = Url.all
    assert_equal 1, all_sites.count
  end

#TODO should this responsibility lie in payload class?

  def test_can_list_urls_by_num_times_requested
    create_payloads

    url_list = Url.sort_url_requests
    assert_equal "http://jumpstartlab.com/", url_list[0]

    assert_equal 3, url_list.count
    assert url_list.include?("http://turing.io/")
    assert url_list.include?("http://yahoo.com/")
  end

  def test_returns_max_response_time_by_url
    create_payloads

    url = Url.find_by(address: "http://jumpstartlab.com/")
    assert_equal 37, Url.max_response_time(url)
  end

  def test_returns_min_response_time_by_url
    create_payloads

    url = Url.find_by(address: "http://turing.io/")
    assert_equal 10, Url.min_response_time(url)
  end

  def test_can_list_ordered_response_times_by_url
    create_payloads

    url = Url.find_by(address: "http://turing.io/")

    sorted_response_times = Url.sorted_response_times(url)

    assert_equal [100, 100, 100, 90, 10], sorted_response_times
  end

  def test_can_list_ordered_response_times_with_different_url
    create_payloads

    url = Url.find_by(address: "http://jumpstartlab.com/")

    sorted_response_times = Url.sorted_response_times(url)

    assert_equal [37, 37, 37, 37, 37, 37, 37, 37, 7], sorted_response_times
  end

  def test_can_find_avg_for_all_response_times_by_url
    create_payloads

    url = Url.find_by(address: "http://turing.io/")

    assert_equal 80.0, Url.average_response_time(url)
  end

  def test_can_find_avg_for_all_responses_with_diff_url
    create_payloads

    url = Url.find_by(address: "http://jumpstartlab.com/")

    assert_equal 33.67, Url.average_response_time(url)

  end

  def test_can_find_http_verbs_by_url
    create_payloads

    url = Url.find_by(address: "http://turing.io/")
    assert_equal ["POST", "PUT", "POST", "POST", "POST"], Url.all_verbs(url)
  end

  def test_can_find_http_verbs_with_different_url
    create_payloads

    url = Url.find_by(address: "http://yahoo.com/")
    assert_equal ["DELETE"], Url.all_verbs(url)
  end

  def test_can_find_three_most_popular_referrers
   create_payloads

    url = Url.find_by(address: "http://jumpstartlab.com/")

    sorted_referrers = Url.popular_referrers(url)

    assert_equal ["http://jumpstartlab.com", "http://google.com", "http://bing.com"], sorted_referrers
  end

  def test_returns_one_referrer_if_only_one_option_in_payloads
   single_turing_payload
   single_turing_payload
   single_turing_payload

    url = Url.find_by(address: "http://turing.io/")

    sorted_referrers = Url.popular_referrers(url)

    assert_equal ["http://google.com"], sorted_referrers
  end

  def test_can_find_three_most_popular_user_agents
   create_payloads

    url = Url.find_by(address: "http://jumpstartlab.com/")

    user_agents = Url.popular_user_agents(url)

    assert_equal [["Macintosh", "Chrome"], ["Macintosh", "Aetscape"], ["Macintosh", "Mozilla"]], user_agents
    assert_equal 3, user_agents.count
  end

  def test_returns_single_user_agent_if_only_popular_option
   single_turing_payload
   single_turing_payload
   single_turing_payload

    url = Url.find_by(address: "http://turing.io/")

    user_agents = Url.popular_user_agents(url)

    assert_equal [["Macintosh", "Chrome"]], user_agents
    assert_equal 1, user_agents.count
  end
end
