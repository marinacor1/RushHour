require_relative "../test_helper"

class DisplayTest < Minitest::Spec

  include TestHelpers

  def test_request_type_knows_all_http_verbs_used
    create_payloads

    all_verbs = RequestType.list_verbs

    assert all_verbs.any? { |verb| verb == "GET" }
    assert all_verbs.any? { |verb| verb == "POST" }
    assert all_verbs.any? { |verb| verb == "DELETE" }
    assert_equal 3, all_verbs.count
  end

  def test_request_type_knows_most_frequent_request_type
    create_payloads

    winner = RequestType.most_requested

    assert_equal "GET", winner
  end

end
