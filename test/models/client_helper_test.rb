require_relative "../test_helper"

class ClientHelperTest < Minitest::Spec
  include TestHelpers

  def test_can_create_multiple_clients_with_valid_attributes
    params = {"identifier"=>"jumpstartlab", "rootUrl"=>"http://jumpstartlab.com"}
    client_helper = ClientHelper.new(params)

    assert_equal 200, client_helper.returned[0]
    assert_equal "identifier: jumpstartlab", client_helper.returned[1]
    assert_equal 1, Client.all.count

    params = {"identifier"=>"google", "rootUrl"=>"http://google.com"}
    client_helper = ClientHelper.new(params)

    assert_equal 200, client_helper.returned[0]
    assert_equal "identifier: google", client_helper.returned[1]
    assert_equal 2, Client.all.count
  end

  def test_403_if_client_already_exists
    params = {"identifier"=>"jumpstartlab", "rootUrl"=>"http://jumpstartlab.com"}
    client_helper = ClientHelper.new(params)

    assert_equal 1, Client.all.count

    params = {"identifier"=>"jumpstartlab", "rootUrl"=>"http://jumpstartlab.com"}
    client_helper = ClientHelper.new(params)

    assert_equal 403, client_helper.returned[0]
    assert_equal "Identifier has already been taken, Root url has already been taken", client_helper.returned[1]
    assert_equal 1, Client.all.count
  end

  def test_400_if_invalid_attributes
    no_id = {"rootUrl"=>"http://jumpstartlab.com"}
    client_helper_id = ClientHelper.new(no_id)

    assert_equal 400, client_helper_id.returned[0]
    assert_equal "Identifier can't be blank", client_helper_id.returned[1]
    assert_equal 0, Client.all.count

    no_url = {"identifier"=>"jumpstartlab"}
    client_helper_url = ClientHelper.new(no_url)

    assert_equal 400, client_helper_url.returned[0]
    assert_equal "Root url can't be blank", client_helper_url.returned[1]
    assert_equal 0, Client.all.count
  end

end
