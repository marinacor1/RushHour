class RequestType < ActiveRecord::Base

  def self.list_verbs
    request_types = PayloadRequest.joins(:request_type).group(:request_type).order("count_all desc").count
    request_types.keys.map {|request_type| request_type.verb}
  end

  def self.most_requested
    self.list_verbs.first
  end
end
