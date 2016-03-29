require_relative "../test_helper"


class DisplayTest < Minitest::Spec

  include TestHelpers

  def test_display_returns_screen_resolutions_for_all_requests
    create_payloads

    resolutions = Display.all

    assert_equal 4, resolutions.count
  end

  def test_display_sdlfksdjf
    create_payloads

    resolutions = Display.all

    assert_equal 4, resolutions.count
  end

end
