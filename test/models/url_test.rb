require_relative "../test_helper"

class UrlTest < Minitest::Spec

  include TestHelpers

  def test_can_list_urls_by_num_times_requested
    create_payloads

    url_list = Url.sort_url_requests

    assert_equal "http://jumpstartlab.com/", url_list[0][0]
    assert_equal "http://turing.io/", url_list[1][0]
    assert_equal "http://yahoo.com/", url_list[2][0]
    assert_equal 3, url_list.count
  end

end
