require_relative 'payload_request'
require_relative 'request_type'

class Url < ActiveRecord::Base

  def self.sort_url_requests
    payloads = PayloadRequest.select(:url_id)
    grouped_payloads = payloads.group_by do |payload|
      payload.url_id
    end
    counted = grouped_payloads.map do |key, value|
      [value.count, Url.find_by(id: key)]
    end.sort.reverse
    result = counted.map do |array|
      array[1].address
    end
  end

  def self.max_response_time(url)
    PayloadRequest.where(url_id: url.id).maximum(:responded_in)
  end

  def self.min_response_time(url)
    PayloadRequest.where(url_id: url.id).minimum(:responded_in)
  end

  def self.sorted_response_times(url)
    payloads = PayloadRequest.where(url_id: url.id).order(responded_in: :desc)
    payloads.all.map { |payload| payload.responded_in}
  end

  def self.average_response_time(url)
    PayloadRequest.where(url_id: url.id).average(:responded_in)
  end

  def self.all_verbs(url)
    payloads = PayloadRequest.where(url_id: url.id)

    request_types = payloads.all.map do |payload|
      RequestType.where(id: payload.request_type_id).list_verbs
    end.flatten
  end

end
