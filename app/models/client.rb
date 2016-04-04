
class Client < ActiveRecord::Base
  include Analytics
  has_many :payload_requests
  has_many :urls, through: :payload_requests
  validates :identifier, presence: true
  validates :identifier, uniqueness: true
  validates :root_url, presence: true
  validates :root_url, uniqueness: true
  #
  # def group_payloads_by(id)
  #   groups = payload_requests.group(id).count
  #   groups.sort_by { |id, count| count}.reverse
  # end

  def popular_request_type
    # groups = group_payloads_by(:request_type_id)
    # [[1, 8], [2, 1]]
    # groups.map do |id, count|
    #   RequestType.where(id: id).pluck(:verb)
    # end.first
    #["GET"]
    # Rachel's suggesion
    # PayloadRequest.joins(:request_type).group(:request_type).order("count_all desc").count
    #What gives the right response
    PayloadRequest.joins(:request_type).group(:request_type).order("count_all desc").count.first.first[:verb]
  end

  def most_popular_urls
    # binding.pry
    urls = PayloadRequest.limit(3).where(client_id: self.id).joins(:url).group(:url).order("count_all desc").count
    urls.keys.map {|url| url.address}
    # PayloadRequest.joins(:url_id).group(Url.address).order("count_all desc").count
    # PayloadRequest.joins(:url).group(:url).order("count_all desc").count.first.first[:address]
    # groups = group_payloads_by(:url_id)
    # groups.map do |url_id, count|
    #   Url.where(id: url_id).pluck(:address)
    # end.flatten
  end

  def browser_breakdown
    users = PayloadRequest.where(client_id: self.id).joins(:user).group(:user).order("count_all desc").count
    users.keys.map {|user| user.browser}

    # groups = group_payloads_by(:user_id)
    # groups.map do |user_id, count|
    #   User.where(id: user_id).pluck(:browser)
    # end.flatten
  end

  def os_breakdown
    # groups = group_payloads_by(:user_id)
    # groups.map do |user_id, count|
    #   User.where(id: user_id).pluck(:os)
    # end.flatten
    users = PayloadRequest.where(client_id: self.id).joins(:user).group(:user).order("count_all desc").count
    users.keys.map {|user| user.os}

  end

  def resolution_breakdown
    # groups = group_payloads_by(:display_id)
    # displays = groups.map do |display_id, count|
    #   Display.where(id: display_id)
    # end.flatten
    displays = PayloadRequest.where(client_id: self.id).joins(:display).group(:display).order("count_all desc").count
    displays.keys.map {|display| "#{display.width} x #{display.height}"}
    # binding.pry
    # displays.map do |display|
    #   "#{display.width} x #{display.height}"
    # end
  end

  def find_relative_path(url)
    path = url.split('/')[3..-1].join('/')
    "/sources/#{self.identifier}/urls/#{path}"
  end

  def find_events
    # payload_requests.select("event_name").map do |payload|
    #   payload.event_name
    # end.uniq
    payloads = PayloadRequest.where(client_id: self.id).pluck(:event_name)
    # displays.keys.map {|display| "#{display.width} x #{display.height}"}
  end
end
