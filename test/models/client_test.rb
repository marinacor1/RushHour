require_relative "../test_helper"

class ClientTest < Minitest::Spec
  include TestHelpers

  def test_client_finds_average_response_time
    client = Client.create(identifier: 'jumpstartlab', root_url: 'http://jumpstartlab.com')
    create_payloads

    assert_equal 33.67, client.average_response
  end

  def test_client_finds_max_response_time
    client = Client.create(identifier: 'jumpstartlab', root_url: 'http://jumpstartlab.com')
    create_payloads

    assert_equal 37.0, client.max_response
  end

  def test_client_finds_min_response_time
    client = Client.create(identifier: 'jumpstartlab', root_url: 'http://jumpstartlab.com')
    create_payloads

    assert_equal 7.0, client.min_response
  end

  def test_client_knows_all_http_verbs
    client = Client.create(identifier: 'jumpstartlab', root_url: 'http://jumpstartlab.com')
    create_payloads

    assert_equal ["GET", "GET", "GET", "GET", "GET", "GET", "GET", "GET", "POST"], client.http_verbs
  end

  def test_client_knows_most_frequent_request_type
    client = Client.create(identifier: 'jumpstartlab', root_url: 'http://jumpstartlab.com')
    create_payloads

    assert_equal ["GET"], client.most_popular_request_type
  end

  def test_clients_knows_sorted_urls
    client = Client.create(identifier: 'jumpstartlab', root_url: 'http://jumpstartlab.com')
    create_payloads

    assert_equal [["http://jumpstartlab.com/"], [], [], []], client.most_popular_urls
  end

  def test_clients_know_browser_breakdown
    client = Client.create(identifier: 'jumpstartlab', root_url: 'http://jumpstartlab.com')
    create_payloads

    assert_equal [["Safari"], ["Chrome"], ["Intel"], ["Aetscape"]], client.most_popular_browsers
  end

# Web browser breakdown across all requests
# OS breakdown across all requests
# Screen Resolutions across all requests (resolutionWidth x resolutionHeight)
end
