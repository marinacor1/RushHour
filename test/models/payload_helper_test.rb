require_relative "../test_helper"

class PayloadHelperTest < Minitest::Spec
  include TestHelpers

  def test_parse_produces_payload_hash
     params = {"payload"=>
      "{\"url\":\"http://jumpstartlab.com/blog\",\"requestedAt\":\"2013-02-16 21:38:28 -0700\",\"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"parameters\":[],\"eventName\":\"socialLogin\",\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.38.211\"}",
     "splat"=>[],
     "captures"=>["jumpstartlab"],
     "id"=>"jumpstartlab"}
     id = "jumpstartlab"
     Client.create(identifier: 'jumpstartlab', root_url: 'http://jumpstartlab.com')
     helper = PayloadHelper.new(params)

    payload = helper.parse(params)
    assert_equal Hash, payload.class
    hash = {"url"=>"http://jumpstartlab.com/blog", "requestedAt"=>"2013-02-16 21:38:28 -0700", "respondedIn"=>37, "referredBy"=>"http://jumpstartlab.com", "requestType"=>"GET", "parameters"=>[], "eventName"=>"socialLogin", "userAgent"=>"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17", "resolutionWidth"=>"1920", "resolutionHeight"=>"1280", "ip"=>"63.29.38.211"}
    assert_equal hash, payload
  end

  def test_can_create_payload_requests
     params = {"payload"=>
      "{\"url\":\"http://jumpstartlab.com/blog\",\"requestedAt\":\"2013-02-16 21:38:28 -0700\",\"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"parameters\":[],\"eventName\":\"socialLogin\",\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.38.211\"}",
     "splat"=>[],
     "captures"=>["jumpstartlab"],
     "id"=>"jumpstartlab"}
     id = "jumpstartlab"
     Client.create(identifier: 'jumpstartlab', root_url: 'http://jumpstartlab.com')
     helper = PayloadHelper.new(params)

    assert PayloadRequest.exists?(url_id: 1)
    assert Url.exists?(address: "http://jumpstartlab.com/blog")
    assert Referrer.exists?(referred_by: "http://jumpstartlab.com")
    assert RequestType.exists?(verb: "GET")
    assert User.exists?(browser: "Chrome")
    assert Display.exists?(width: "1920")
  end

  def test_can_return_200_for_good_client_and_payload
     params = {"payload"=>
      "{\"url\":\"http://jumpstartlab.com/blog\",\"requestedAt\":\"2013-02-16 21:38:28 -0700\",\"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"parameters\":[],\"eventName\":\"socialLogin\",\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.38.211\"}",
     "splat"=>[],
     "captures"=>["jumpstartlab"],
     "id"=>"jumpstartlab"}
     id = "jumpstartlab"
     Client.create(identifier: 'jumpstartlab', root_url: 'http://jumpstartlab.com')
     helper = PayloadHelper.new(params)

    assert_equal 200, helper.returned[0]
    assert_equal "happy", helper.returned[1]
  end

  def test_can_return_400_when_no_payload_data
     params = {"payload" => nil}
     id = "jumpstartlab"
     Client.create(identifier: 'jumpstartlab', root_url: 'http://jumpstartlab.com')
     helper = PayloadHelper.new(params)

    assert_equal 400, helper.returned[0]
    assert_equal "Url can't be blank ,Requested at can't be blank ,Responded in can't be blank ,Referrer can't be blank ,Request type can't be blank ,Event name can't be blank ,User can't be blank ,Display can't be blank ,Ip can't be blank ,Param can't be blank", helper.returned[1]
  end

  def test_can_return_403_when_client_does_not_exist
     params = {"payload"=>
      "{\"url\":\"http://jumpstartlab.com/blog\",\"requestedAt\":\"2013-02-16 21:38:28 -0700\",\"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"parameters\":[],\"eventName\":\"socialLogin\",\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.38.211\"}",
     "splat"=>[],
     "captures"=>["jumpstartlab"],
     "id"=>"jumpstartlab"}
     id = "jumpstartlab"
     Client.create(identifier: 'mtv', root_url: 'http://mtv.com')
     helper = PayloadHelper.new(params)

    assert_equal 403, helper.returned[0]
    assert_equal "Client does not exist", helper.returned[1]
  end

end
