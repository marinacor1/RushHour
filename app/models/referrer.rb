class Referrer < ActiveRecord::Base
  has_many :payload_requests
  has_many :urls, through: :payload_requests
  def self.list_referrers
    # referrer_count = self.select(:referred_by).group(:referred_by).count
    # sorted = referrer_count.sort_by { |referrer, count| count }
    # sorted.reverse.map { |referrer, count| referrer }

    #Payload - hash with referrer id => # of times it occurs


  end
end
