class RequestType < ActiveRecord::Base

  def self.list_verbs
    # verb_count = self.select(:verb).group(:verb).having("count(*) > 0").count
    # var = verb_count.sort_by do |verb, count|
    #   count
    # end.reverse.map { |verb, count| verb }
    # binding.pry
    request_types = PayloadRequest.joins(:request_type).group(:request_type).order("count_all desc").count
    request_types.keys.map {|request_type| request_type.verb}
  end

  def self.most_requested
    # payloads = PayloadRequest.select(:request_type_id)
    # grouped_payloads = payloads.group_by do |payload|
    #   payload.request_type_id
    # end
    # counted = grouped_payloads.map do |key, value|
    #   [value.count, RequestType.find_by(id: key)]
    # end.sort.reverse
    # result = counted.map do |array|
    #   array[1].verb
    # end.first
    # binding.pry
    self.list_verbs.first
  end
end
