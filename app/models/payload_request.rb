require 'pry'

class PayloadRequest < ActiveRecord::Base
  belongs_to :url
  belongs_to :request
  belongs_to :request_type
  belongs_to :user
  belongs_to :display
  validates :url_id, presence: true
  validates :requestedAt, presence: true
  validates :respondedIn, presence: true
  validates :request_id, presence: true
  validates :request_type_id, presence: true
  validates :eventName, presence: true
  validates :user_id, presence: true
  validates :display_id, presence: true
  validates :ip, presence: true
end
