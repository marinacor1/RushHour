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
    url_list = Url.sort_url_requests
    # require 'pry';binding.pry
    assert_equal "http://jumpstartlab.com/", url_list[0][0]
    assert_equal "http://turing.io/", url_list[1][0]
    assert_equal "http://yahoo.com/", url_list[2][0]
    assert_equal 3, url_list.count
  end

  def test_returns_max_response_time_by_url
    url = Url.find_by(address: "http://jumpstartlab.com/")
    assert_equal 37, Url.max_response_time(url)
  end

end
