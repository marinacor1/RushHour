require_relative '../test_helper'

class CreatePayloadTest < Minitest::Test
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

  def test_can_create_payload_with_valid_attributes
    assert_equal 0, PayloadRequest.count

    post '/sources', {identifier: 'jumpstartlab', rootUrl: 'http://jumpstartlab.com' }
    assert_equal "jumpstartlab", Client.all.first.identifier

    post '/sources/jumpstartlab/data',
    {"payload"=>
      "{\"url\":\"http://jumpstartlab.com/blog\",\"requestedAt\":\"2013-02-16 21:38:28 -0700\",\"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"parameters\":[],\"eventName\":\"socialLogin\",\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.38.211\"}",
     "splat"=>[],
     "captures"=>["jumpstartlab"],
     "id"=>"jumpstartlab"}
    # {"url":"http://jumpstartlab.com/blog","requestedAt":"2013-02-16 21:38:28 -0700",
    # "respondedIn":37,"referredBy":"http://jumpstartlab.com",
    # "requestType":"GET","parameters":[],"eventName":"socialLogin",
    # "userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
    # "resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211"}

    assert_equal 1, PayloadRequest.count
    assert_equal 200, last_response.status
    assert_equal 37, PayloadRequest.first.responded_in
    assert_equal "http://jumpstartlab.com/blog", Url.first.address
  end
end
