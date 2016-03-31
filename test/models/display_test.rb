require_relative "../test_helper"


class DisplayTest < Minitest::Spec

  include TestHelpers

  def test_display_returns_screen_resolutions_for_all_requests
    create_payloads

    resolutions = Display.screen_resolutions

    assert_equal Array, resolutions.class
    assert_equal ["1920 x 1280", "120 x 180", "9000 x 9000", "4000 x 4000", "192 x 128", "120 x 1280", "190 x 123"], resolutions
  end

  def test_display_does_not_have_duplicates
    create_payloads

    resolutions = Display.screen_resolutions

    assert_equal resolutions, resolutions.uniq
  end


end
