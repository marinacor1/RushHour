require_relative 'payload_request'
require_relative 'request_type'

class Url < ActiveRecord::Base
  has_many :payload_requests
  has_many :referrers, through: :payload_requests
  has_many :users, through: :payload_requests

  def max_response_time
    payload_requests.maximum(:responded_in)
  end

  def min_response_time
    payload_requests.minimum(:responded_in)
  end

  def min_response_time
    payload_requests.minimum(:responded_in)
  end

  def sorted_response_times
    payloads = payload_requests.order(responded_in: :desc)
    x = payloads.map { |payload| payload.responded_in }
  end

  def average_response_time
    payload_requests.average(:responded_in).to_f.round(2)
  end

  def all_verbs
    payload_requests.map do |payload|
      RequestType.where(id: payload.request_type_id)[0].verb
    end
  end

  def popular_referrers
    popular = payload_requests.group(:referrer_id).count
    grouped_referrers = referrers.group(:referred_by).count
    grouped_referrers.keys[0..2]
  end

  def popular_user_agents
    popular = payload_requests.group(:user_id).count
    sorted = popular.sort_by do |user_id, count|
      count
    end.reverse
    sorted.map do |user_id, count|
      User.where(id: user_id).pluck(:os, :browser)
    end[0..2]
  end
end
