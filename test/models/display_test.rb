require_relative "../test_helper"


class DisplayTest < Minitest::Spec

  include TestHelpers

  def test_display_returns_screen_resolutions_for_all_requests
    create_payloads

    resolutions = Display.screen_resolutions

    assert resolutions.any? { |resolution| resolution == "1920 x 1280" }
    assert resolutions.any? { |resolution| resolution == "9000 x 9000" }
    assert resolutions.any? { |resolution| resolution == "4000 x 4000" }
  end

end
