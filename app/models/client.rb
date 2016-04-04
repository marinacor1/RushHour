
class Client < ActiveRecord::Base
  include Analytics
  has_many :payload_requests
  has_many :urls, through: :payload_requests
  validates :identifier, presence: true
  validates :identifier, uniqueness: true
  validates :root_url, presence: true
  validates :root_url, uniqueness: true

  def popular_request_type
    PayloadRequest.joins(:request_type).group(:request_type).order("count_all desc").count.first.first[:verb]
  end

  def most_popular_urls
    urls = PayloadRequest.limit(3).where(client_id: self.id).joins(:url).group(:url).order("count_all desc").count
    urls.keys.map {|url| url.address}
  end

  def browser_breakdown
    users = PayloadRequest.where(client_id: self.id).joins(:user).group(:user).order("count_all desc").count
    users.keys.map {|user| user.browser}
  end

  def os_breakdown
    users = PayloadRequest.where(client_id: self.id).joins(:user).group(:user).order("count_all desc").count
    users.keys.map {|user| user.os}
  end

  def resolution_breakdown
    displays = PayloadRequest.where(client_id: self.id).joins(:display).group(:display).order("count_all desc").count
    displays.keys.map {|display| "#{display.width} x #{display.height}"}
  end

  def find_relative_path(url)
    path = url.split('/')[3..-1].join('/')
    "/sources/#{self.identifier}/urls/#{path}"
  end

  def find_events
    payloads = PayloadRequest.where(client_id: self.id).pluck(:event_name)
  end
end
