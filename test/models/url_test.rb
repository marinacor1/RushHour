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

    url = Url.find_by(address: "http://turing.io/")
    assert_equal 10, Url.min_response_time(url)
  end

  def test_can_list_ordered_response_times_by_url

    url = Url.find_by(address: "http://turing.io/")

    sorted_response_times = Url.sorted_response_times(url)

    assert_equal [100, 100, 100, 90, 10], sorted_response_times
  end

  def test_can_find_avg_for_all_response_times_by_url

    url = Url.find_by(address: "http://turing.io/")

    assert_equal 80.0, Url.average_response_time(url).to_f
  end

  def test_can_find_http_verbs_by_url

    url = Url.find_by(address: "http://turing.io/")
    assert_equal ["POST", "PUT", "POST", "POST", "POST"], Url.all_verbs(url)
  end

  def test_can_find_three_most_popular_referrers

    url = Url.find_by(address: "http://jumpstartlab.com/")

    sorted_referrers = Url.popular_referrers(url)

    assert_equal ["http://jumpstartlab.com", "http://google.com", "http://askjeeves.com"], sorted_referrers
  end

  def test_can_find_three_most_popular_user_agents

    url = Url.find_by(address: "http://jumpstartlab.com/")

    user_agents = Url.popular_user_agents(url)

    assert_equal [["Macintosh", "Chrome"], ["Macintosh", "Aetscape"], ["Macintosh", "Mozilla"]], user_agents
    assert_equal 3, user_agents.count
  end

end
