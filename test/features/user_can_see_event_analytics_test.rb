require_relative '../test_helper'

class UserCanSeeEventAnalytics < Minitest::Test
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

  def test_user_can_see_event_analytics
    post '/sources', {identifier: 'jumpstartlab', rootUrl: 'http://jumpstartlab.com' }

    post '/sources/jumpstartlab/data',
    {"payload"=>
      "{\"url\":\"http://jumpstartlab.com/blog\",\"requestedAt\":\"2013-02-16 21:38:28 -0700\",\"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"parameters\":[],\"eventName\":\"socialLogin\",\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.38.211\"}",
     "splat"=>[],
     "captures"=>["jumpstartlab"],
     "id"=>"jumpstartlab"}

     visit "/sources/jumpstartlab/events/socialLogin"
     assert page.has_content? "21:00 hrs: 1"
     assert page.has_content? "socialLogin occurs 1 times."
   end

  def test_user_can_see_event_analytics_for_two_payloads
    post '/sources', {identifier: 'jumpstartlab', rootUrl: 'http://jumpstartlab.com' }

    post '/sources/jumpstartlab/data',
    {"payload"=>
      "{\"url\":\"http://jumpstartlab.com/blog\",\"requestedAt\":\"2013-02-16 21:38:28 -0700\",\"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"parameters\":[],\"eventName\":\"socialLogin\",\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.38.211\"}",
     "splat"=>[],
     "captures"=>["jumpstartlab"],
     "id"=>"jumpstartlab"}

    post '/sources/jumpstartlab/data',
    {"payload"=>
      "{\"url\":\"http://jumpstartlab.com/blog\",\"requestedAt\":\"2013-02-16 13:38:28 -0700\",\"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"parameters\":[],\"eventName\":\"socialLogin\",\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.38.211\"}",
     "splat"=>[],
     "captures"=>["jumpstartlab"],
     "id"=>"jumpstartlab"}

     visit "/sources/jumpstartlab/events/socialLogin"
     assert page.has_content? "21:00 hrs: 1"
     assert page.has_content? "13:00 hrs: 1"
     assert page.has_content? "socialLogin occurs 2 times."

   end

  def test_user_can_see_event_analytics_for_three_payloads_with_same_hour
    post '/sources', {identifier: 'jumpstartlab', rootUrl: 'http://jumpstartlab.com' }
    post '/sources/jumpstartlab/data',
    {"payload"=>
      "{\"url\":\"http://jumpstartlab.com/blog\",\"requestedAt\":\"2013-02-16 21:38:28 -0700\",\"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"parameters\":[],\"eventName\":\"socialLogin\",\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.38.211\"}",
     "splat"=>[],
     "captures"=>["jumpstartlab"],
     "id"=>"jumpstartlab"}

    post '/sources/jumpstartlab/data',
    {"payload"=>
      "{\"url\":\"http://jumpstartlab.com/blog\",\"requestedAt\":\"2013-02-16 13:38:28 -0700\",\"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"parameters\":[],\"eventName\":\"socialLogin\",\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.38.211\"}",
     "splat"=>[],
     "captures"=>["jumpstartlab"],
     "id"=>"jumpstartlab"}

    post '/sources/jumpstartlab/data',
    {"payload"=>
      "{\"url\":\"http://jumpstartlab.com/blog\",\"requestedAt\":\"2013-02-16 13:38:24 -0700\",\"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"parameters\":[],\"eventName\":\"socialLogin\",\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.38.211\"}",
     "splat"=>[],
     "captures"=>["jumpstartlab"],
     "id"=>"jumpstartlab"}

     visit "/sources/jumpstartlab/events/socialLogin"
     assert page.has_content? "21:00 hrs: 1"
     assert page.has_content? "13:00 hrs: 2"
     assert page.has_content? "socialLogin occurs 3 times."
   end

   def test_user_gets_error_page_if_event_does_not_exist
    post '/sources', {identifier: 'jumpstartlab', rootUrl: 'http://jumpstartlab.com' }

     visit "/sources/jumpstartlab/events/socialLogin"
     assert page.has_content? "Event does not exist."
   end

   def test_user_can_browse_to_all_events_from_event_error_page
     post '/sources', {identifier: 'jumpstartlab', rootUrl: 'http://jumpstartlab.com' }

     post '/sources/jumpstartlab/data',
     {"payload"=>
       "{\"url\":\"http://jumpstartlab.com/blog\",\"requestedAt\":\"2013-02-16 21:38:28 -0700\",\"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"parameters\":[],\"eventName\":\"socialLogin\",\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.38.211\"}",
      "splat"=>[],
      "captures"=>["jumpstartlab"],
      "id"=>"jumpstartlab"}

      visit "/sources/jumpstartlab/events/nonevent"

      click_link("View events")

      assert_equal "/sources/jumpstartlab/events", current_path

      click_link("socialLogin")

      assert_equal "/sources/jumpstartlab/events/socialLogin", current_path
   end

   def test_user_can_see_all_events
     post '/sources', {identifier: 'jumpstartlab', rootUrl: 'http://jumpstartlab.com' }
     post '/sources/jumpstartlab/data',
     {"payload"=>
       "{\"url\":\"http://jumpstartlab.com/blog\",\"requestedAt\":\"2013-02-16 21:38:28 -0700\",\"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"parameters\":[],\"eventName\":\"event1\",\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.38.211\"}",
      "splat"=>[],
      "captures"=>["jumpstartlab"],
      "id"=>"jumpstartlab"}

     post '/sources/jumpstartlab/data',
     {"payload"=>
       "{\"url\":\"http://jumpstartlab.com/blog\",\"requestedAt\":\"2013-02-16 13:38:28 -0700\",\"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"parameters\":[],\"eventName\":\"event2\",\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.38.211\"}",
      "splat"=>[],
      "captures"=>["jumpstartlab"],
      "id"=>"jumpstartlab"}

     post '/sources/jumpstartlab/data',
     {"payload"=>
       "{\"url\":\"http://jumpstartlab.com/blog\",\"requestedAt\":\"2013-02-16 13:38:24 -0700\",\"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"parameters\":[],\"eventName\":\"event3\",\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.38.211\"}",
      "splat"=>[],
      "captures"=>["jumpstartlab"],
      "id"=>"jumpstartlab"}

      visit "/sources/jumpstartlab"

      click_link "View events"

      assert_equal "/sources/jumpstartlab/events", current_path
      assert page.has_content? "Event Index"
      assert page.has_content? "event1"
      assert page.has_content? "event2"
      assert page.has_content? "event3"
   end

   def test_client_can_get_home_from_events
     post '/sources', {identifier: 'jumpstartlab', rootUrl: 'http://jumpstartlab.com' }
     post '/sources/jumpstartlab/data',
     {"payload"=>
       "{\"url\":\"http://jumpstartlab.com/blog\",\"requestedAt\":\"2013-02-16 21:38:28 -0700\",\"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"parameters\":[],\"eventName\":\"event1\",\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.38.211\"}",
      "splat"=>[],
      "captures"=>["jumpstartlab"],
      "id"=>"jumpstartlab"}

      visit "/sources/jumpstartlab"

      click_link "View events"

      click_on "Stats for jumpstartlab"

      assert_equal "/sources/jumpstartlab", current_path
   end
end
