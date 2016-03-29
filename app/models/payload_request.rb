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
end
