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

  def test_client_finds_min_response_time
    client = Client.create(identifier: 'jumpstartlab', root_url: 'http://jumpstartlab.com')
    create_payloads

    assert_equal 7.0, client.min_response
  end

  def test_client_knows_all_http_verbs
    client = Client.create(identifier: 'jumpstartlab', root_url: 'http://jumpstartlab.com')
    create_payloads

    assert_equal ["GET", "GET", "GET", "GET", "GET", "GET", "GET", "GET", "POST"], client.http_verbs
  end

  def test_client_knows_most_frequent_request_type
    client = Client.create(identifier: 'jumpstartlab', root_url: 'http://jumpstartlab.com')
    create_payloads

    assert_equal ["GET"], client.most_popular_request_type
  end

  def test_clients_knows_sorted_urls
    client = Client.create(identifier: 'jumpstartlab', root_url: 'http://jumpstartlab.com')
    PayloadRequest.create({ url_id: Url.find_or_create_by(address: "http://jumpstartlab.com/blog").id,
                            requested_at: "2013-02-16 21:38:28 -0700",
                            responded_in: 37,
                            referrer_id: Referrer.find_or_create_by(referred_by:"http://askjeeves.com").id,
                            request_type_id: RequestType.find_or_create_by(verb: "GET").id,
                            event_name: "socialLogin",
                            user_id: User.find_or_create_by(browser: UserAgent.parse("Safari/537.17").browser,
                                                 os: UserAgent.parse("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17").platform
                                                 ).id,
                            display_id: Display.find_or_create_by(width: "120", height: "180").id,
                            ip: "63.29.38.211",
                            client_id: 1,
                            param: "20"
                          })
  PayloadRequest.create({ url_id: Url.find_or_create_by(address: "http://jumpstartlab.com/article").id,
                        requested_at: "2013-02-16 21:38:28 -0700",
                        responded_in: 37,
                        referrer_id: Referrer.find_or_create_by(referred_by:"http://askjeeves.com").id,
                        request_type_id: RequestType.find_or_create_by(verb: "GET").id,
                        event_name: "socialLogin",
                        user_id: User.find_or_create_by(browser: UserAgent.parse("Safari/537.17").browser,
                                             os: UserAgent.parse("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17").platform
                                             ).id,
                        display_id: Display.find_or_create_by(width: "120", height: "180").id,
                        ip: "63.29.38.211",
                        client_id: 1,
                        param: "21"
                      })

    assert_equal ["http://jumpstartlab.com/article", "http://jumpstartlab.com/blog"], client.most_popular_urls
  end

  def test_clients_know_browser_breakdown
    client = Client.create(identifier: 'jumpstartlab', root_url: 'http://jumpstartlab.com')
    create_payloads

    assert_equal 4, client.browser_breakdown.count
    assert client.browser_breakdown.include?("Safari")
    assert client.browser_breakdown.include?("Chrome")
    assert client.browser_breakdown.include?("Intel")
    assert client.browser_breakdown.include?("Aetscape")
    assert_equal Array, client.browser_breakdown.class
  end

  def test_clients_know_os_breakdown
    client = Client.create(identifier: 'jumpstartlab', root_url: 'http://jumpstartlab.com')
    create_payloads

    assert_equal 4, client.os_breakdown.count
    assert client.os_breakdown.include?("Macintosh")
    assert client.os_breakdown.include?("Windows")
    assert_equal Array, client.os_breakdown.class
  end

  def test_clients_know_screen_resolutions
    client = Client.create(identifier: 'jumpstartlab', root_url: 'http://jumpstartlab.com')
    create_payloads

    PayloadRequest.create({ url_id: Url.find_or_create_by(address: "http://jumpstartlab.com/article").id,
                          requested_at: "2013-02-16 21:38:28 -0700",
                          responded_in: 37,
                          referrer_id: Referrer.find_or_create_by(referred_by:"http://askjeeves.com").id,
                          request_type_id: RequestType.find_or_create_by(verb: "GET").id,
                          event_name: "socialLogin",
                          user_id: User.find_or_create_by(browser: UserAgent.parse("Safari/537.17").browser,
                                               os: UserAgent.parse("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17").platform
                                               ).id,
                          display_id: Display.find_or_create_by(width: "1920", height: "1280").id,
                          ip: "63.29.38.211",
                          client_id: 1,
                          param: "21"
                        })

    assert client.resolution_breakdown.include? ("1920 x 1280")
    assert client.resolution_breakdown.include? ("190 x 123")
    assert client.resolution_breakdown.include? ("192 x 128")
    assert client.resolution_breakdown.include? ("120 x 180")
    assert client.resolution_breakdown.include? ("120 x 1280")

  end

end
