class Client < ActiveRecord::Base
  has_many :payload_requests
  validates :identifier, presence: true
  validates :identifier, uniqueness: true 
end
