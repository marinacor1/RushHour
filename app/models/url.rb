require_relative 'payload_request'
require_relative 'request_type'

class Url < ActiveRecord::Base
  has_many :payload_requests
  has_many :referrers, through: :payload_requests
  has_many :users, through: :payload_requests

  def self.payloads_of(url)
    if url == "all"
      PayloadRequest.all
    else
      PayloadRequest.where(url_id: url.id)
    end
  end


  def self.group_by_count_of(url, attribute)
    self.payloads_of(url).group(attribute).count.sort_by do |attribute, count|
      count
    end.reverse
  end

  def self.get_result_from(attribute_ids, attribute)
    attribute_ids.map do |id_pair|
      if attribute == "referred_by"
        Referrer.where(id: id_pair[0]).first.referred_by
      elsif attribute == "browser"
        User.where(id: id_pair[0]).first.browser
      elsif attribute == "os"
        User.where(id: id_pair[0]).first.os
      elsif attribute == "address"
        Url.where(id: id_pair[0]).first.address
      end
    end
  end

  def self.sort_url_requests
    sorted_ids = self.group_by_count_of("all", :url_id)
    most_urls = self.get_result_from(sorted_ids, "address")
  end

  def self.max_response_time(url)
    self.payloads_of(url).maximum(:responded_in)
  end

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
    request_types = payload_requests.map do |payload|
      RequestType.where(id: payload.request_type_id)[0].verb
    end
  end

  def popular_referrers
    popular = payload_requests.group(:referrer_id).count
    grouped_referrers = referrers.group(:referred_by).count
    grouped_referrers.keys[0..2]
  end

  def popular_user_agents
    #TODO this would be worth looking at and seeing
    #if our test output was wrong initially or if it's wrong now
    popular = payload_requests.group(:user_id).count
    grouped_systems = users.group(:os).count
    grouped_browsers = users.group(:browser).count
    (grouped_systems.keys).zip(grouped_browsers.keys)
    # binding.pry
    # sorted_ids = self.group_by_count_of(url, :user_id)
    # browsers = self.get_result_from(sorted_ids, "browser")
    # systems = self.get_result_from(sorted_ids, "os")
    # systems.zip(browsers)[0..2]
  end
end
