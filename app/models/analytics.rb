module Analytics
  def max_response_time
    payload_requests.maximum(:responded_in)
  end

  def min_response_time
    payload_requests.minimum(:responded_in)
  end

  def sorted_response_times
    payloads = payload_requests.order(responded_in: :desc)
    payloads.map { |payload| payload.responded_in }
  end

  def average_response_time
    payload_requests.average(:responded_in).to_f.round(2)
  end

  def all_verbs
    payload_requests.map do |payload|
      RequestType.where(id: payload.request_type_id)[0].verb
    end
  end
end
