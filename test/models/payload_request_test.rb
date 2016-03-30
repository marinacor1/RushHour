require_relative '../test_helper'
require 'pry'

class PayloadRequestTest < Minitest::Spec
  include TestHelpers

  def setup
    create_payloads
  end

  def test_payload_request_knows_its_attributes
    # insert string from payload request into database
    payload = PayloadRequest.create({
                                  url_id: Url.create(address: 'http://jumpstartlab.com/blog').id,
                                  requested_at: "2013-02-16 21:38:28 -0700",
                                  responded_in: 37,
                                  request_id: Request.create(referred_by:"http://jumpstartlab.com").id,
                                  request_type_id: RequestType.create(verb: "GET").id,
                                  event_name: "socialLogin",
                                  user_id: User.create(browser: UserAgent.parse("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17").browser,
                                                       os: UserAgent.parse("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17").platform
                                                       ).id,
                                  display_id: Display.create(width: "1920", height: "1280").id,
                                  ip: "63.29.38.211"
                                })


    assert_equal "http://jumpstartlab.com/blog", payload.url.address
    assert_equal Date.parse("2013-02-16 21:38:28 -0700"), payload.requested_at
    assert_equal 37, payload.responded_in
    assert_equal "http://jumpstartlab.com", payload.request.referred_by
    assert_equal "GET", payload.request_type.verb
    assert_equal "socialLogin", payload.event_name
    assert_equal "Chrome", payload.user.browser
    assert_equal "Macintosh", payload.user.os
    assert_equal "1920", payload.display.width
    assert_equal "1280", payload.display.height
    assert_equal "63.29.38.211", payload.ip
  end

  def test_it_calculates_average_response_time

    assert_equal 66.0, PayloadRequest.average_response_time.to_f
  end

  def test_it_calculates_maximum_response_time

    assert_equal 100, PayloadRequest.maximum_response_time
  end

  def test_it_calculates_minimum_response_time

    assert_equal 37, PayloadRequest.minimum_response_time
  end

  def test_it_lists_events_in_order_of_frequency
    events = PayloadRequest.order_events
    assert_equal "lastentry", events.first.event_name
    assert_equal "socialLogin", events.last.event_name
  end

  def test_payload_is_valid 
    assert PayloadRequest.create({
                                  url_id: Url.create(address: 'http://jumpstartlab.com/blog').id,
                                  requested_at: "2013-02-16 21:38:28 -0700",
                                  responded_in: 37,
                                  request_id: Request.create(referred_by:"http://jumpstartlab.com").id,
                                  request_type_id: RequestType.create(verb: "GET").id,
                                  event_name: "socialLogin",
                                  user_id: User.create(browser: UserAgent.parse("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17").browser,
                                                       os: UserAgent.parse("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17").platform
                                                       ).id,
                                  display_id: Display.create(width: "1920", height: "1280").id,
                                  ip: "63.29.38.211"
                                }).valid?
  end

  def test_payload_is_not_valid_if_url_is_missing 
    refute PayloadRequest.create({
                                  requested_at: "2013-02-16 21:38:28 -0700",
                                  responded_in: 37,
                                  request_id: Request.create(referred_by:"http://jumpstartlab.com").id,
                                  request_type_id: RequestType.create(verb: "GET").id,
                                  event_name: "socialLogin",
                                  user_id: User.create(browser: UserAgent.parse("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17").browser,
                                                       os: UserAgent.parse("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17").platform
                                                       ).id,
                                  display_id: Display.create(width: "1920", height: "1280").id,
                                  ip: "63.29.38.211"
                                }).valid?
  end

  def test_payload_is_not_valid_if_requested_at_is_missing 
    refute PayloadRequest.create({
                                  url_id: Url.create(address: 'http://jumpstartlab.com/blog').id,
                                  responded_in: 37,
                                  request_id: Request.create(referred_by:"http://jumpstartlab.com").id,
                                  request_type_id: RequestType.create(verb: "GET").id,
                                  event_name: "socialLogin",
                                  user_id: User.create(browser: UserAgent.parse("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17").browser,
                                                       os: UserAgent.parse("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17").platform
                                                       ).id,
                                  display_id: Display.create(width: "1920", height: "1280").id,
                                  ip: "63.29.38.211"
                                }).valid?
  end

  def test_payload_is_not_valid_if_responded_in_is_missing 
    refute PayloadRequest.create({
                                  url_id: Url.create(address: 'http://jumpstartlab.com/blog').id,
                                  requested_at: "2013-02-16 21:38:28 -0700",
                                  request_id: Request.create(referred_by:"http://jumpstartlab.com").id,
                                  request_type_id: RequestType.create(verb: "GET").id,
                                  event_name: "socialLogin",
                                  user_id: User.create(browser: UserAgent.parse("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17").browser,
                                                       os: UserAgent.parse("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17").platform
                                                       ).id,
                                  display_id: Display.create(width: "1920", height: "1280").id,
                                  ip: "63.29.38.211"
                                }).valid?
  end

  def test_payload_is_not_valid_if_referred_by_is_missing 
    refute PayloadRequest.create({
                                  url_id: Url.create(address: 'http://jumpstartlab.com/blog').id,
                                  requested_at: "2013-02-16 21:38:28 -0700",
                                  responded_in: 37,
                                  request_type_id: RequestType.create(verb: "GET").id,
                                  event_name: "socialLogin",
                                  user_id: User.create(browser: UserAgent.parse("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17").browser,
                                                       os: UserAgent.parse("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17").platform
                                                       ).id,
                                  display_id: Display.create(width: "1920", height: "1280").id,
                                  ip: "63.29.38.211"
                                }).valid?
  end

  def test_payload_is_not_valid_if_request_type_is_missing
    refute PayloadRequest.create({
                                  url_id: Url.create(address: 'http://jumpstartlab.com/blog').id,
                                  requested_at: "2013-02-16 21:38:28 -0700",
                                  responded_in: 37,
                                  request_id: Request.create(referred_by:"http://jumpstartlab.com").id,
                                  event_name: "socialLogin",
                                  user_id: User.create(browser: UserAgent.parse("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17").browser,
                                                       os: UserAgent.parse("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17").platform
                                                       ).id,
                                  display_id: Display.create(width: "1920", height: "1280").id,
                                  ip: "63.29.38.211"
                                }).valid?
  end

  def test_payload_is_not_valid_if_event_name_is_missing
    refute PayloadRequest.create({
                                  url_id: Url.create(address: 'http://jumpstartlab.com/blog').id,
                                  requested_at: "2013-02-16 21:38:28 -0700",
                                  responded_in: 37,
                                  request_id: Request.create(referred_by:"http://jumpstartlab.com").id,
                                  request_type_id: RequestType.create(verb: "GET").id,
                                  user_id: User.create(browser: UserAgent.parse("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17").browser,
                                                       os: UserAgent.parse("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17").platform
                                                       ).id,
                                  display_id: Display.create(width: "1920", height: "1280").id,
                                  ip: "63.29.38.211"
                                }).valid?
  end

  def test_payload_is_not_valid_if_user_agent_is_missing
    refute PayloadRequest.create({
                                  url_id: Url.create(address: 'http://jumpstartlab.com/blog').id,
                                  requested_at: "2013-02-16 21:38:28 -0700",
                                  responded_in: 37,
                                  request_id: Request.create(referred_by:"http://jumpstartlab.com").id,
                                  request_type_id: RequestType.create(verb: "GET").id,
                                  event_name: "socialLogin",
                                  display_id: Display.create(width: "1920", height: "1280").id,
                                  ip: "63.29.38.211"
                                }).valid?
  end

  def test_payload_is_not_valid_if_res_missing
    refute PayloadRequest.create({
                                  url_id: Url.create(address: 'http://jumpstartlab.com/blog').id,
                                  requested_at: "2013-02-16 21:38:28 -0700",
                                  responded_in: 37,
                                  request_id: Request.create(referred_by:"http://jumpstartlab.com").id,
                                  request_type_id: RequestType.create(verb: "GET").id,
                                  event_name: "socialLogin",
                                  user_id: User.create(browser: UserAgent.parse("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17").browser,
                                                       os: UserAgent.parse("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17").platform
                                                       ).id,
                                  ip: "63.29.38.211"
                                }).valid?
  end

  def test_payload_is_not_valid_if_ip_is_missing
    refute PayloadRequest.create({
                                  url_id: Url.create(address: 'http://jumpstartlab.com/blog').id,
                                  requested_at: "2013-02-16 21:38:28 -0700",
                                  responded_in: 37,
                                  request_id: Request.create(referred_by:"http://jumpstartlab.com").id,
                                  request_type_id: RequestType.create(verb: "GET").id,
                                  event_name: "socialLogin",
                                  user_id: User.create(browser: UserAgent.parse("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17").browser,
                                                       os: UserAgent.parse("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17").platform
                                                       ).id,
                                  display_id: Display.create(width: "1920", height: "1280").id,
                                }).valid?
  end

end
