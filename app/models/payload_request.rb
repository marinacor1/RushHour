require 'pry'

class PayloadRequest < ActiveRecord::Base
  belongs_to :url
  belongs_to :referrer
  belongs_to :request_type
  belongs_to :user
  belongs_to :display
  validates :url_id, presence: true
  validates :requested_at, presence: true
  validates :responded_in, presence: true
  validates :referrer_id, presence: true
  validates :request_type_id, presence: true
  validates :event_name, presence: true
  validates :user_id, presence: true
  validates :display_id, presence: true
  validates :ip, presence: true
  validates :param, presence: true
  validates :param, uniqueness: true

  def self.average_response_time
    average = self.average(:responded_in)
    average.to_f.round(2)
  end

  def self.maximum_response_time
    self.maximum(:responded_in)
  end

  def self.minimum_response_time
    self.minimum(:responded_in)
  end

  def self.order_events
    events = self.order(event_name: :desc)
    events.map do |event|
      event.event_name
    end.uniq
  end

  def self.order_requested_urls
    sorted_ids = PayloadRequest.all.group(:url_id).count.sort_by do |attribute, count|
      count
    end.reverse
    sorted_ids.map do |id_pair|
      Url.where(id: id_pair[0]).first.address
    end
  end

  def show_status
    if self.nil?
      [400, self.errors.full_messages.join(", ")]
    elsif self == :unknown_client
      status 403
      body "not a known client root url"
      # body errors.full_messages.join(", ")
    elsif self.save
      status = 200
    else
      status 403
      body "This is a duplicate"
      # body errors.full_messages.join(", ")
    end
  end

end
