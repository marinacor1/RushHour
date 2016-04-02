require_relative "../test_helper"

class ClientHelperTest < Minitest::Spec
  include TestHelpers

  def setup
    @params = {"identifier" => "jumpstartlab", "rootUrl" => "http://jumpstartlab.com"}
    @client_helper = Client.new(@params)
  end

  def test_can_create_client_with_valid_attributes
  end

end
