require_relative "../test_helper"

class DisplayTest < Minitest::Spec
  include TestHelpers

  def test_request_type_knows_all_http_verbs_used
    create_payloads

    all_verbs = RequestType.list_verbs

    assert_equal 4, all_verbs.count
    assert_equal ["POST", "PUT", "GET", "DELETE"], all_verbs
    assert_equal all_verbs, all_verbs.uniq
  end

  def test_request_type_knows_most_frequent_request_type
    create_payloads

    winner = RequestType.most_requested

    assert_equal "GET", winner
  end

  def test_request_type_removes_duplicates
    single_payload
    single_payload

    verbs = RequestType.most_requested
    assert_equal "GET", verbs
  end

end
