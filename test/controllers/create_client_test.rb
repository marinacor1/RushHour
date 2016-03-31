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

  def test_can_create_client_with_valid_attributes
    assert_equal 0, Client.count

    post '/sources', {client: {identifier: 'jumpstartlab', rootUrl: 'http://jumpstartlab.com' }}

    assert_equal 1, Client.count
    assert_equal 200, last_response.status
    assert_equal "jumpstartlab", Client.all.first.identifier
    assert_equal "http://jumpstartlab.com", Client.all.first.root_url
  end

  def test_cannot_create_client_with_invalid_attributes
    assert_equal 0, Client.count

    post '/sources', {client: {}}

    assert_equal 0, Client.count
    assert_equal 400, last_response.status
  end



end
