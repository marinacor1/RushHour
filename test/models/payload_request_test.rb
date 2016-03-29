require_relative '../test_helper'
require 'pry'

class PayloadRequestTest < Minitest::Test
  def test_payload_request_knows_its_attributes
    # insert string from payload request into database
    payload = PayloadRequest.create({
                                  url_id: Url.create(address: 'http://jumpstartlab.com/blog').id,
                                  # url: Url.create(address: 'fdslkfh'),
                                  # "url":"http://jumpstartlab.com/blog",
                                  "requestedAt":"2013-02-16 21:38:28 -0700",
                                  "respondedIn":37,
                                  request_id: Request.create(referred_by:"http://jumpstartlab.com").id,
                                  # referred_by: Referrer.create(address: "http://jumpstartlab.com"),
                                  request_type_id: RequestType.create(verb: "GET").id,
                                  "eventName": "socialLogin",
                                  user_id: User.create(browser: UserAgent.parse("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17").browser,
                                                       os: UserAgent.parse("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17").platform
                                                       ).id,
                                  display_id: Display.create(width: "1920", height: "1280").id,
                                  # "resolutionWidth":"1920",
                                  # "resolutionHeight":"1280",
                                  "ip":"63.29.38.211"
                                })


    assert_equal "http://jumpstartlab.com/blog", payload.url.address
    assert_equal Date.parse("2013-02-16 21:38:28 -0700"), payload.requestedAt
    assert_equal 37, payload.respondedIn
    assert_equal "http://jumpstartlab.com", payload.request.referred_by
    assert_equal "GET", payload.request_type.verb
    assert_equal "socialLogin", payload.eventName
    assert_equal "Chrome", payload.user.browser
    assert_equal "Macintosh", payload.user.os
    assert_equal "1920", payload.display.width
    assert_equal "1280", payload.display.height
    assert_equal "63.29.38.211", payload.ip
  end

#   def test_payload_is_valid 
#     assert PayloadRequest.create({
#                                   "url":"http://jumpstartlab.com/blog",
#                                   "request_at":"2013-02-16 21:38:28 -0700",
#                                   "responded_in":37,
#                                   "referredBy":"http://jumpstartlab.com",
#                                   "requestType":"GET",
#                                   "eventName": "socialLogin",
#                                   "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
#                                   "resolutionWidth":"1920",
#                                   "resolutionHeight":"1280",
#                                   "ip":"63.29.38.211"
#                                 }).valid?
#   end
#
#   def test_payload_is_not_valid_if_url_is_missing 
#     refute PayloadRequest.create({
#                                   "request_at":"2013-02-16 21:38:28 -0700",
#                                   "responded_in":37,
#                                   "referredBy":"http://jumpstartlab.com",
#                                   "requestType":"GET",
#                                   "eventName": "socialLogin",
#                                   "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
#                                   "resolutionWidth":"1920",
#                                   "resolutionHeight":"1280",
#                                   "ip":"63.29.38.211"
#                                 }).valid?
#   end
#
#   def test_payload_is_not_valid_if_requested_at_is_missing 
#     refute PayloadRequest.create({
#                                   "url":"http://jumpstartlab.com/blog",
#                                   "responded_in":37,
#                                   "referredBy":"http://jumpstartlab.com",
#                                   "requestType":"GET",
#                                   "eventName": "socialLogin",
#                                   "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
#                                   "resolutionWidth":"1920",
#                                   "resolutionHeight":"1280",
#                                   "ip":"63.29.38.211"
#                                 }).valid?
#   end
#
#   def test_payload_is_not_valid_if_responded_in_is_missing 
#     refute PayloadRequest.create({
#                                   "url":"http://jumpstartlab.com/blog",
#                                   "request_at":"2013-02-16 21:38:28 -0700",
#                                   "referredBy":"http://jumpstartlab.com",
#                                   "requestType":"GET",
#                                   "eventName": "socialLogin",
#                                   "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
#                                   "resolutionWidth":"1920",
#                                   "resolutionHeight":"1280",
#                                   "ip":"63.29.38.211"
#                                 }).valid?
#   end
#
#   def test_payload_is_not_valid_if_referred_by_is_missing 
#     refute PayloadRequest.create({
#                                   "url":"http://jumpstartlab.com/blog",
#                                   "request_at":"2013-02-16 21:38:28 -0700",
#                                   "responded_in":37,
#                                   "requestType":"GET",
#                                   "eventName": "socialLogin",
#                                   "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
#                                   "resolutionWidth":"1920",
#                                   "resolutionHeight":"1280",
#                                   "ip":"63.29.38.211"
#                                 }).valid?
#   end
#
#   def test_payload_is_not_valid_if_request_type_is_missing
#     refute PayloadRequest.create({
#                                   "url":"http://jumpstartlab.com/blog",
#                                   "request_at":"2013-02-16 21:38:28 -0700",
#                                   "responded_in":37,
#                                   "referredBy":"http://jumpstartlab.com",
#                                   "eventName": "socialLogin",
#                                   "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
#                                   "resolutionWidth":"1920",
#                                   "resolutionHeight":"1280",
#                                   "ip":"63.29.38.211"
#                                 }).valid?
#   end
#
#   def test_payload_is_not_valid_if_event_name_is_missing
#     refute PayloadRequest.create({
#                                   "url":"http://jumpstartlab.com/blog",
#                                   "request_at":"2013-02-16 21:38:28 -0700",
#                                   "responded_in":37,
#                                   "referredBy":"http://jumpstartlab.com",
#                                   "requestType":"GET",
#                                   "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
#                                   "resolutionWidth":"1920",
#                                   "resolutionHeight":"1280",
#                                   "ip":"63.29.38.211"
#                                 }).valid?
#   end
#
#   def test_payload_is_not_valid_if_user_agent_is_missing
#     refute PayloadRequest.create({
#                                   "url":"http://jumpstartlab.com/blog",
#                                   "request_at":"2013-02-16 21:38:28 -0700",
#                                   "responded_in":37,
#                                   "referredBy":"http://jumpstartlab.com",
#                                   "requestType":"GET",
#                                   "eventName": "socialLogin",
#                                   "resolutionWidth":"1920",
#                                   "resolutionHeight":"1280",
#                                   "ip":"63.29.38.211"
#                                 }).valid?
#   end
#
#   def test_payload_is_not_valid_if_res_width_missing
#     refute PayloadRequest.create({
#                                   "url":"http://jumpstartlab.com/blog",
#                                   "request_at":"2013-02-16 21:38:28 -0700",
#                                   "responded_in":37,
#                                   "referredBy":"http://jumpstartlab.com",
#                                   "requestType":"GET",
#                                   "eventName": "socialLogin",
#                                   "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
#                                   "resolutionHeight":"1280",
#                                   "ip":"63.29.38.211"
#                                 }).valid?
#   end
#
#   def test_payload_is_not_valid_if_res_height_missing
#     refute PayloadRequest.create({
#                                   "url":"http://jumpstartlab.com/blog",
#                                   "request_at":"2013-02-16 21:38:28 -0700",
#                                   "responded_in":37,
#                                   "referredBy":"http://jumpstartlab.com",
#                                   "requestType":"GET",
#                                   "eventName": "socialLogin",
#                                   "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
#                                   "resolutionWidth":"1920",
#                                   "ip":"63.29.38.211"
#                                 }).valid?
#   end
#
#   def test_payload_is_not_valid_if_ip_is_missing
#     refute PayloadRequest.create({
#                                   "url":"http://jumpstartlab.com/blog",
#                                   "request_at":"2013-02-16 21:38:28 -0700",
#                                   "responded_in":37,
#                                   "referredBy":"http://jumpstartlab.com",
#                                   "requestType":"GET",
#                                   "eventName": "socialLogin",
#                                   "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
#                                   "resolutionWidth":"1920",
#                                   "resolutionHeight":"1280",
#                                 }).valid?
#   end
#
end
