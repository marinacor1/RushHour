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

    assert_equal 1, PayloadRequest.count
    assert_equal 200, last_response.status
    assert_equal "happy", last_response.body
    assert_equal 37, PayloadRequest.first.responded_in
    assert_equal "http://jumpstartlab.com/blog", Url.first.address
  end

  def test_403_returned_when_payload_has_already_been_recieved
    assert_equal 0, PayloadRequest.count

    post '/sources', {identifier: 'jumpstartlab', rootUrl: 'http://jumpstartlab.com' }
    assert_equal "jumpstartlab", Client.all.first.identifier
#the following is curl request input
    post '/sources/jumpstartlab/data',
    {"payload"=>
      "{\"url\":\"http://jumpstartlab.com/blog\",\"requestedAt\":\"2013-02-16 21:38:28 -0700\",\"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"parameters\":[],\"eventName\":\"socialLogin\",\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.38.211\"}",
     "splat"=>[],
     "captures"=>["jumpstartlab"],
     "id"=>"jumpstartlab"}

     assert_equal 1, PayloadRequest.count
     assert_equal 200, last_response.status

     post '/sources/jumpstartlab/data',
     {"payload"=>
       "{\"url\":\"http://jumpstartlab.com/blog\",\"requestedAt\":\"2013-02-16 21:38:28 -0700\",\"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"parameters\":[],\"eventName\":\"socialLogin\",\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.38.211\"}",
      "splat"=>[],
      "captures"=>["jumpstartlab"],
      "id"=>"jumpstartlab"}

      assert_equal 1, PayloadRequest.count
      assert_equal 403, last_response.status
      assert_equal "Param has already been taken", last_response.body
  end

  def test_returns_400_if_missing_payload
    assert_equal 0, PayloadRequest.count

    post '/sources', {identifier: 'jumpstartlab', rootUrl: 'http://jumpstartlab.com' }
    assert_equal "jumpstartlab", Client.all.first.identifier

    post '/sources/jumpstartlab/data', nil

    assert_equal 0, PayloadRequest.count
    assert_equal 400, last_response.status
    assert_equal "Url can't be blank ,Requested at can't be blank ,Responded in can't be blank ,Referrer can't be blank ,Request type can't be blank ,Event name can't be blank ,User can't be blank ,Display can't be blank ,Ip can't be blank ,Param can't be blank", last_response.body
  end

  def test_return_403_if_not_a_know_root_url
    skip
    assert_equal 0, PayloadRequest.count

    post '/sources/jumpstartlab/data',
    {"payload"=>
      "{\"url\":\"http://jumpstartlab.com/blog\",\"requestedAt\":\"2013-02-16 21:38:28 -0700\",\"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"parameters\":[],\"eventName\":\"socialLogin\",\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.38.211\"}",
     "splat"=>[],
     "captures"=>["jumpstartlab"],
     "id"=>"jumpstartlab"}

    assert_equal 0, PayloadRequest.count
    assert_equal 403, last_response.status
    assert_equal "not a known client root url", last_response.body
  end

end
