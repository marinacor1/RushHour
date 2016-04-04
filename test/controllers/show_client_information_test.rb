require './test/test_helper'

class CreateClientTest < Minitest::Test
  include Rack::Test::Methods

  def app
    RushHour::Server
  end

  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end

  def test_can_show_client_error_if_no_client
    assert_equal 0, Client.count

    post '/sources/marina', {identifier: 'jumpstartlab', rootUrl: 'http://jumpstartlab.com' }

    assert_equal 404, last_response.status
  end

  def test_can_show_payload_error_if_no_payload
    assert_equal 0, Client.count

    post '/sources/jumpstartlab', {identifier: 'jumpstartlab', rootUrl: 'http://jumpstartlab.com' }

    assert_equal 404, last_response.status
  end

  def test_can_show_client_info
    post '/sources/jumpstartlab', {identifier: 'jumpstartlab', rootUrl: 'http://jumpstartlab.com' }
    {"payload"=>
      "{\"url\":\"http://jumpstartlab.com/blog\",\"requestedAt\":\"2013-02-16 21:38:28 -0700\",\"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"parameters\":[],\"eventName\":\"socialLogin\",\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.38.211\"}",
     "splat"=>[],
     "captures"=>["jumpstartlab"],
     "id"=>"jumpstartlab"}

    assert_equal 404, last_response.status
  end

end
