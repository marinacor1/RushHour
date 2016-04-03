require_relative 'payload_request'
require_relative 'request_type'

class Url < ActiveRecord::Base
  include Analytics
  has_many :payload_requests
  has_many :referrers, through: :payload_requests
  has_many :users, through: :payload_requests

  def popular_referrers
    popular = payload_requests.group(:referrer_id).count
    grouped_referrers = referrers.group(:referred_by).count
    grouped_referrers.keys[0..2]
  end

  def popular_user_agents
    popular = payload_requests.group(:user_id).count
    sorted = popular.sort_by do |user_id, count|
      count
    end.reverse
    sorted.map do |user_id, count|
      User.where(id: user_id).pluck(:os, :browser)
    end[0..2]
  end
end
