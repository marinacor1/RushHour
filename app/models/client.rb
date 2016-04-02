
class Client < ActiveRecord::Base
  has_many :payload_requests
  validates :identifier, presence: true
  validates :identifier, uniqueness: true
  validates :root_url, presence: true
  validates :root_url, uniqueness: true

  def average_response
    payload_requests.average(:responded_in).to_f.round(2)
  end

end
