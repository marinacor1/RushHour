require_relative 'payload_request'
require_relative 'request_type'

class Url < ActiveRecord::Base
  include Analytics
  has_many :payload_requests
  has_many :referrers, through: :payload_requests
  has_many :users, through: :payload_requests

  def popular_referrers
    referrers = PayloadRequest.limit(3).where(url_id: self.id).joins(:referrer).group(:referrer).order("count_all desc").count
    referrers.keys.map {|referrer| referrer.referred_by}
  end

  def popular_user_agents
    users = PayloadRequest.limit(3).where(url_id: self.id).joins(:user).group(:user).order("count_all desc").count
    users.keys.map {|user| "#{user.os} & #{user.browser}"}
  end
end
