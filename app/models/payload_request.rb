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
    # TODO do we want this uniq? self.select(:event_name).uniq
    self.order(event_name: :desc)
  end

  def self.order_requested_urls
    sorted_ids = PayloadRequest.all.group(:url_id).count.sort_by do |attribute, count|
      count
    end.reverse
    sorted_ids.map do |id_pair|
      Url.where(id: id_pair[0]).first.address
    end
  end
end
