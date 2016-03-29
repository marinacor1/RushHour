require_relative "../test_helper"


class DisplayTest < Minitest::Test

  include TestHelpers

  def test_display_returns_screen_resolutions_for_all_requests
    create_payloads

    resolutions = Display.all

    assert_equal 1234, resolutions
  end

end
