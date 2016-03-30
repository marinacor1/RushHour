require_relative 'payload_request'

class Url < ActiveRecord::Base

  def self.sort_url_requests
    # verb_count is a hash with key = url, value = count of key
    url_count = self.select(:address).group(:address).having("count(*) > 0").count
    # sort_by the count + reverse returns list of urls in descending order of count
    # might need to do a better job of using sql here
    url_count.sort_by do |url, count|
      count
    end.reverse
  end

  def self.max_response_time(url)
    PayloadRequest.where(url_id: url.id).maximum(:responded_in)
  end

end
