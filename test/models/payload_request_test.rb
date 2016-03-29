require_relative '../test_helper'
require 'pry'

class PayloadRequestTest < Minitest::Test
  def test_payload_request_knows_its_attributes
    # insert string from payload request into database
    payload = PayloadRequest.create({
                                  "url":"http://jumpstartlab.com/blog",
                                  "requestedAt":"2013-02-16 21:38:28 -0700",
                                  "respondedIn":37,
                                  "referredBy":"http://jumpstartlab.com",
                                  "requestType":"GET",
                                  "eventName": "socialLogin",
                                  "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                                  "resolutionWidth":"1920",
                                  "resolutionHeight":"1280",
                                  "ip":"63.29.38.211"
                                })


    assert_equal "http://jumpstartlab.com/blog", payload.url
    assert_equal Date.parse("2013-02-16 21:38:28 -0700"), payload.requestedAt
    assert_equal 37, payload.respondedIn
    assert_equal "http://jumpstartlab.com", payload.referredBy
    assert_equal "GET", payload.requestType
    assert_equal "socialLogin", payload.eventName
    assert_equal "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17", payload.userAgent
    assert_equal "1920", payload.resolutionWidth
    assert_equal "1280", payload.resolutionHeight
    assert_equal "63.29.38.211", payload.ip
  end

  def test_payload_is_valid 
    assert PayloadRequest.create({
                                  "url":"http://jumpstartlab.com/blog",
                                  "requestedAt":"2013-02-16 21:38:28 -0700",
                                  "respondedIn":37,
                                  "referredBy":"http://jumpstartlab.com",
                                  "requestType":"GET",
                                  "eventName": "socialLogin",
                                  "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                                  "resolutionWidth":"1920",
                                  "resolutionHeight":"1280",
                                  "ip":"63.29.38.211"
                                }).valid?
  end

  def test_payload_is_not_valid_if_url_is_missing 
    refute PayloadRequest.create({
                                  "requestedAt":"2013-02-16 21:38:28 -0700",
                                  "respondedIn":37,
                                  "referredBy":"http://jumpstartlab.com",
                                  "requestType":"GET",
                                  "eventName": "socialLogin",
                                  "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                                  "resolutionWidth":"1920",
                                  "resolutionHeight":"1280",
                                  "ip":"63.29.38.211"
                                }).valid?
  end

  def test_payload_is_not_valid_if_requested_at_is_missing 
    refute PayloadRequest.create({
                                  "url":"http://jumpstartlab.com/blog",
                                  "respondedIn":37,
                                  "referredBy":"http://jumpstartlab.com",
                                  "requestType":"GET",
                                  "eventName": "socialLogin",
                                  "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                                  "resolutionWidth":"1920",
                                  "resolutionHeight":"1280",
                                  "ip":"63.29.38.211"
                                }).valid?
  end

  def test_payload_is_not_valid_if_responded_in_is_missing 
    refute PayloadRequest.create({
                                  "url":"http://jumpstartlab.com/blog",
                                  "requestedAt":"2013-02-16 21:38:28 -0700",
                                  "referredBy":"http://jumpstartlab.com",
                                  "requestType":"GET",
                                  "eventName": "socialLogin",
                                  "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                                  "resolutionWidth":"1920",
                                  "resolutionHeight":"1280",
                                  "ip":"63.29.38.211"
                                }).valid?
  end

  def test_payload_is_not_valid_if_referred_by_is_missing 
    refute PayloadRequest.create({
                                  "url":"http://jumpstartlab.com/blog",
                                  "requestedAt":"2013-02-16 21:38:28 -0700",
                                  "respondedIn":37,
                                  "requestType":"GET",
                                  "eventName": "socialLogin",
                                  "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                                  "resolutionWidth":"1920",
                                  "resolutionHeight":"1280",
                                  "ip":"63.29.38.211"
                                }).valid?
  end

  def test_payload_is_not_valid_if_request_type_is_missing
    refute PayloadRequest.create({
                                  "url":"http://jumpstartlab.com/blog",
                                  "requestedAt":"2013-02-16 21:38:28 -0700",
                                  "respondedIn":37,
                                  "referredBy":"http://jumpstartlab.com",
                                  "eventName": "socialLogin",
                                  "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                                  "resolutionWidth":"1920",
                                  "resolutionHeight":"1280",
                                  "ip":"63.29.38.211"
                                }).valid?
  end

  def test_payload_is_not_valid_if_event_name_is_missing
    refute PayloadRequest.create({
                                  "url":"http://jumpstartlab.com/blog",
                                  "requestedAt":"2013-02-16 21:38:28 -0700",
                                  "respondedIn":37,
                                  "referredBy":"http://jumpstartlab.com",
                                  "requestType":"GET",
                                  "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                                  "resolutionWidth":"1920",
                                  "resolutionHeight":"1280",
                                  "ip":"63.29.38.211"
                                }).valid?
  end

  def test_payload_is_not_valid_if_user_agent_is_missing
    refute PayloadRequest.create({
                                  "url":"http://jumpstartlab.com/blog",
                                  "requestedAt":"2013-02-16 21:38:28 -0700",
                                  "respondedIn":37,
                                  "referredBy":"http://jumpstartlab.com",
                                  "requestType":"GET",
                                  "eventName": "socialLogin",
                                  "resolutionWidth":"1920",
                                  "resolutionHeight":"1280",
                                  "ip":"63.29.38.211"
                                }).valid?
  end

  def test_payload_is_not_valid_if_res_width_missing
    refute PayloadRequest.create({
                                  "url":"http://jumpstartlab.com/blog",
                                  "requestedAt":"2013-02-16 21:38:28 -0700",
                                  "respondedIn":37,
                                  "referredBy":"http://jumpstartlab.com",
                                  "requestType":"GET",
                                  "eventName": "socialLogin",
                                  "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                                  "resolutionHeight":"1280",
                                  "ip":"63.29.38.211"
                                }).valid?
  end

  def test_payload_is_not_valid_if_res_height_missing
    refute PayloadRequest.create({
                                  "url":"http://jumpstartlab.com/blog",
                                  "requestedAt":"2013-02-16 21:38:28 -0700",
                                  "respondedIn":37,
                                  "referredBy":"http://jumpstartlab.com",
                                  "requestType":"GET",
                                  "eventName": "socialLogin",
                                  "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                                  "resolutionWidth":"1920",
                                  "ip":"63.29.38.211"
                                }).valid?
  end

  def test_payload_is_not_valid_if_ip_is_missing
    refute PayloadRequest.create({
                                  "url":"http://jumpstartlab.com/blog",
                                  "requestedAt":"2013-02-16 21:38:28 -0700",
                                  "respondedIn":37,
                                  "referredBy":"http://jumpstartlab.com",
                                  "requestType":"GET",
                                  "eventName": "socialLogin",
                                  "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                                  "resolutionWidth":"1920",
                                  "resolutionHeight":"1280",
                                }).valid?
  end

end
