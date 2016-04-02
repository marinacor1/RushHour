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

  def test_user_can_see_url_analytics
    post '/sources', {identifier: 'jumpstartlab', rootUrl: 'http://jumpstartlab.com' }
    assert_equal "jumpstartlab", Client.all.first.identifier

    post '/sources/jumpstartlab/data',
    {"payload"=>
      "{\"url\":\"http://jumpstartlab.com/blog\",\"requestedAt\":\"2013-02-16 21:38:28 -0700\",\"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"parameters\":[],\"eventName\":\"socialLogin\",\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.38.211\"}",
     "splat"=>[],
     "captures"=>["jumpstartlab"],
     "id"=>"jumpstartlab"}

    visit "/sources/jumpstartlab"
save_and_open_page
    click_link('http://jumpstartlab.com/blog')
    assert current_path "/sources/jumpstartlab/urls/blog"
    assert page.has_content?("Max Response time: 37")
    assert page.has_content?("Min Response time: 37")
    assert page.has_content?("Average Response time: 37")
    assert page.has_content? "HTTP Verb(s) associated used to it this URL: [\"GET\"]"
  end

  def test_user_gets_error_if_no_payloads
    skip
    post '/sources', {identifier: 'jumpstartlab', rootUrl: 'http://jumpstartlab.com' }
    assert_equal "jumpstartlab", Client.all.first.identifier

    visit "/sources/jumpstartlab/urls/sdlfjs"
    assert page.has_content?("This URL has not been requested.")
  end

end
