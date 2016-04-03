require './test/test_helper'

class CreateClientTest < Minitest::Test
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

  def test_can_redirect_to_error_page_with_not_found_url
    get '/marina'

    assert_equal 404, last_response.status
  end
end
