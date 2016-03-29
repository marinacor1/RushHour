require_relative '../test_helper'

class PayloadRequestTest < Minitest::Test
  payload = PayloadRequest.new({
                                "url":"http://jumpstartlab.com/blog",
                                "requestedAt":"2013-02-16 21:38:28 -0700",
                                "respondedIn":37,
                                "referredBy":"http://jumpstartlab.com",
                                "requestType":"GET",
                                "parameters":[],
                                "eventName": "socialLogin",
                                "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                                "resolutionWidth":"1920",
                                "resolutionHeight":"1280",
                                "ip":"63.29.38.211"
                              })

  assert_equal "http://jumpstartlab.com/blog", payload.url
  assert_equal "2013-02-16 21:38:28 -0700", payload.requestedAt
  assert_equal 37, payload.respondedIn
  assert_equal "http://jumpstartlab.com", payload.referredBy
  assert_equal "GET", payload.requestType
  assert_equal [], payload.parameters
  assert_equal "socialLogin", payload.eventName
  assert_equal "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17", payload.userAgent
  assert_equal "1920", payload.resolutionWidth
  assert_equal "1280", payload.resolutionHeight
  assert_equal "63.29.38.211", payload.ip
end
