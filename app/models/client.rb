
class Client < ActiveRecord::Base
  has_many :payload_requests
  validates :identifier, presence: true
  validates :identifier, uniqueness: true
  validates :root_url, presence: true
  validates :root_url, uniqueness: true

  def average_response
    payload_requests.average(:responded_in).to_f.round(2)
  end

  def max_response
    payload_requests.maximum(:responded_in).to_f.round(2)
  end

  def min_response
    payload_requests.minimum(:responded_in).to_f.round(2)
  end

  def http_verbs
    payload_requests.map do |payload|
      RequestType.where(id: payload.request_type_id)[0].verb
    end
  end

  def most_popular_request_type
    popular = payload_requests.group(:request_type_id).count
    sorted = popular.sort_by do |id, count|
      count
    end.reverse
    answer = sorted.map do |id, count|
      RequestType.where(id: id).pluck(:verb)
    end.first
  end

  def most_popular_urls
    popular = payload_requests.group(:user_id).count
    sorted = popular.sort_by do |url_id, count|
      count
    end.reverse
    sorted.map do |url_id, count|
      Url.where(id: url_id).pluck(:address)
    end
  end

  def browser_breakdown
    popular = payload_requests.group(:user_id).count
    sorted = popular.sort_by do |user_id, count|
      count
    end.reverse
    sorted.map do |user_id, count|
      User.where(id: user_id).pluck(:browser)
    end.flatten
  end

  def os_breakdown
    popular = payload_requests.group(:user_id).count
    sorted = popular.sort_by do |user_id, count|
      count
    end.reverse
    sorted.map do |user_id, count|
      User.where(id: user_id).pluck(:os)
    end.flatten
  end

  def resolution_breakdown
    popular = payload_requests.group(:display_id).count
    sorted = popular.sort_by do |display_id, count|
      count
    end.reverse
    displays = sorted.map do |display_id, count|
      Display.where(id: display_id)
    end.flatten
      displays.map do |display|
        "#{display.width} x #{display.height}"
      end
  end

end
