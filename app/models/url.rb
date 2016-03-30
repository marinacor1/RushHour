require_relative 'payload_request'

class Url < ActiveRecord::Base
  validates :address, uniqueness: true
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
    #find url_id
    #find_by url_id in payload request
    #sort by responded in
    #return max
    # url_id = self.find_by(address: url.address).id
    # payloads = PayloadRequest.find_each(url_id: url.id) { |payload| payload.url_id == url.id}
    # payloads.count
    # payloads = PayloadRequest.find(:all, :conditions => ["SELECT * FROM"])
    PayloadRequest.where(url_id: url.id)
  end

end
