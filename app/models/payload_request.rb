require 'pry'

class PayloadRequest < ActiveRecord::Base
  belongs_to :url
  belongs_to :request
  belongs_to :request_type
  belongs_to :user
  belongs_to :display
  validates :url_id, presence: true
  validates :requested_at, presence: true
  validates :responded_in, presence: true
  validates :request_id, presence: true
  validates :request_type_id, presence: true
  validates :event_name, presence: true
  validates :user_id, presence: true
  validates :display_id, presence: true
  validates :ip, presence: true

  def self.average_response_time
    self.average(:responded_in)
  end

  def self.maximum_response_time
    self.maximum(:responded_in)
  end

  def self.minimum_response_time
    self.minimum(:responded_in)
  end

  def self.order_events
    self.order(:event_name)
  end
end
