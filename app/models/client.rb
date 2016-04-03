
class Client < ActiveRecord::Base
  include Analytics
  has_many :payload_requests
  has_many :urls, through: :payload_requests
  validates :identifier, presence: true
  validates :identifier, uniqueness: true
  validates :root_url, presence: true
  validates :root_url, uniqueness: true

  def group_payloads_by(id)
    groups = payload_requests.group(id).count
    groups.sort_by do |id, count|
      count
    end.reverse
  end

  def popular_request_type
    groups = group_payloads_by(:request_type_id)
    groups.map do |id, count|
      RequestType.where(id: id).pluck(:verb)
    end.first
  end

  def most_popular_urls
    groups = group_payloads_by(:url_id)
    groups.map do |url_id, count|
      Url.where(id: url_id).pluck(:address)
    end.flatten
  end

  def browser_breakdown
    groups = group_payloads_by(:user_id)
    groups.map do |user_id, count|
      User.where(id: user_id).pluck(:browser)
    end.flatten
  end

  def os_breakdown
    groups = group_payloads_by(:user_id)
    groups.map do |user_id, count|
      User.where(id: user_id).pluck(:os)
    end.flatten
  end

  def resolution_breakdown
    groups = group_payloads_by(:display_id)
    displays = groups.map do |display_id, count|
      Display.where(id: display_id)
    end.flatten
    displays.map do |display|
      "#{display.width} x #{display.height}"
    end
  end

  def find_relative_path(url)
    path = url.split('/')[3..-1].join('/')
    "/sources/#{self.identifier}/urls/#{path}"
  end

end
