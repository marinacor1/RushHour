require_relative '../test_helper'

class UserCanSeeURLAnalytics < Minitest::Test
  include TestHelpers
  include Capybara::DSL
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

  def test_user_can_see_client_analytics
    post '/sources', {identifier: 'jumpstartlab', rootUrl: 'http://jumpstartlab.com' }
    assert_equal "jumpstartlab", Client.all.first.identifier

    post '/sources/jumpstartlab/data',
    {"payload"=>
      "{\"url\":\"http://jumpstartlab.com/blog\",\"requestedAt\":\"2013-02-16 21:38:28 -0700\",\"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"parameters\":[],\"eventName\":\"socialLogin\",\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.38.211\"}",
     "splat"=>[],
     "captures"=>["jumpstartlab"],
     "id"=>"jumpstartlab"}

     visit "/sources/jumpstartlab"

     assert page.has_content? "jumpstartlab"
     assert page.has_content? "GET"
     assert page.has_content? 37
  end

  def test_user_can_see_data_for_multiple_payloads
    post '/sources', {identifier: 'jumpstartlab', rootUrl: 'http://jumpstartlab.com' }
    assert_equal "jumpstartlab", Client.all.first.identifier

    post '/sources/jumpstartlab/data',
    {"payload"=>
      "{\"url\":\"http://jumpstartlab.com/article\",\"requestedAt\":\"2013-02-16 02:38:28 -0700\",\"respondedIn\":55,\"referredBy\":\"http://google.com\",\"requestType\":\"POST\",\"parameters\":[],\"eventName\":\"search\",\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1000\",\"resolutionHeight\":\"800\",\"ip\":\"64.29.38.211\"}",
      "splat"=>[],
      "captures"=>["jumpstartlab"],
      "id"=>"jumpstartlab"}

    post '/sources/jumpstartlab/data',
    {"payload"=>
      "{\"url\":\"http://jumpstartlab.com/blog\",\"requestedAt\":\"2013-02-16 21:38:28 -0700\",\"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"parameters\":[],\"eventName\":\"socialLogin\",\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.38.211\"}",
     "splat"=>[],
     "captures"=>["jumpstartlab"],
     "id"=>"jumpstartlab"}
    #  client = Client.all.last
     visit "/sources/jumpstartlab"
     assert page.has_content? "jumpstartlab"
     assert page.has_content? "GET"
     assert page.has_content? 37
     assert page.has_content? "jumpstartlab.com/blog"
     assert page.has_content? "jumpstartlab.com/article"
  end

  def test_user_will_get_error_if_client_id_does_not_exist
    assert_equal 0, Client.all.count

    visit '/sources/jumpstartlab'
#TODO add id later
    assert page.has_content? "Client does not exist."
  end

  def test_user_will_get_error_if_payload_does_not_exist
    post '/sources', {identifier: 'jumpstartlab', rootUrl: 'http://jumpstartlab.com' }
    assert_equal "jumpstartlab", Client.all.first.identifier
    assert_equal 0, PayloadRequest.all.count

    visit '/sources/jumpstartlab'
    assert page.has_content? "Client does not have any payloads."
  end
end
