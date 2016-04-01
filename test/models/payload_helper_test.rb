require_relative "../test_helper"

class PayloadHelperTest < Minitest::Spec
  include TestHelpers

  def setup
     @params = {"payload"=>
      "{\"url\":\"http://jumpstartlab.com/blog\",\"requestedAt\":\"2013-02-16 21:38:28 -0700\",\"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"parameters\":[],\"eventName\":\"socialLogin\",\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.38.211\"}",
     "splat"=>[],
     "captures"=>["jumpstartlab"],
     "id"=>"jumpstartlab"}
     id = "jumpstartlab"
     Client.create(identifier: 'jumpstartlab', root_url: 'http://jumpstartlab.com')
     @helper = PayloadHelper.new(@params)
    #  @helper.payload.save
  end

  def test_parse_produces_payload_hash
    payload = @helper.parse(@params)
    assert_equal Hash, payload.class
    hash = {"url"=>"http://jumpstartlab.com/blog", "requestedAt"=>"2013-02-16 21:38:28 -0700", "respondedIn"=>37, "referredBy"=>"http://jumpstartlab.com", "requestType"=>"GET", "parameters"=>[], "eventName"=>"socialLogin", "userAgent"=>"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17", "resolutionWidth"=>"1920", "resolutionHeight"=>"1280", "ip"=>"63.29.38.211"}
    assert_equal hash, payload
  end

  def test_can_create_payload_requests
    assert PayloadRequest.exists?(url_id: 1)
    assert Url.exists?(address: "http://jumpstartlab.com/blog")
    assert Referrer.exists?(referred_by: "http://jumpstartlab.com")
    assert RequestType.exists?(verb: "GET")
    assert User.exists?(browser: "Chrome")
    assert Display.exists?(width: "1920")
  end

  def test_can_return_200_for_good_client_and_payload
    assert_equal 200, @helper
  end

  def test_can_return_400_when_no_payload_data

  end
end
