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


# Max Response time across all requests
# Min Response time across all requests
# Most frequent request type
# List of all HTTP verbs used
# List of URLs listed form most requested to least requested
# Web browser breakdown across all requests
# OS breakdown across all requests
# Screen Resolutions across all requests (resolutionWidth x resolutionHeight)
end
