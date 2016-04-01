require_relative '../test_helper'

class UserCanCreateANewRobot < Minitest::Test
  include TestHelpers
  include Capybara::DSL

  def test_user_can_see_url_analytics
    client = Client.create(identifier: "jumpstartlab", root_url: "http://jumpstartlab.com" )
    create_payloads
binding.pry
    identifier = client.identifier

    visit "/sources/#{identifier}"
save_and_open_page
    assert page.has_content? "#{identifier}"
    # binding.pry
  end

end
