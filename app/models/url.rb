require_relative 'payload_request'
require_relative 'request_type'

class Url < ActiveRecord::Base
  include Analytics
  has_many :payload_requests
  has_many :referrers, through: :payload_requests
  has_many :users, through: :payload_requests

  def popular_referrers
    # popular = payload_requests.group(:referrer_id).count
    # grouped_referrers = referrers.group(:referred_by).count
    # sorted = grouped_referrers.sort_by do |referrer, count|
    #   count
    # end.reverse
    # top_three = sorted[0..2]
    # names = top_three.map {|pair| pair.first}
    referrers = PayloadRequest.limit(3).where(url_id: self.id).joins(:referrer).group(:referrer).order("count_all desc").count
    referrers.keys.map {|referrer| referrer.referred_by}
  end

  def popular_user_agents
    # popular = payload_requests.group(:user_id).count
    # sorted = popular.sort_by do |user_id, count|
    #   count
    # end.reverse
    # sorted.map do |user_id, count|
    #   User.where(id: user_id).pluck(:os, :browser)
    # end[0..2]
    users = PayloadRequest.limit(3).where(url_id: self.id).joins(:user).group(:user).order("count_all desc").count
    users.keys.map {|user| "#{user.os} & #{user.browser}"}
  end
end
