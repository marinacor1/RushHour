class RequestType < ActiveRecord::Base

  def self.list_verbs
    verb_count = self.select(:verb).group(:verb).having("count(*) > 0").count
    verb_count.sort_by do |verb, count|
      count
    end.reverse.map { |verb, count| verb }
  end

  def self.most_requested
    payloads = PayloadRequest.select(:request_type_id)
    grouped_payloads = payloads.group_by do |payload|
      payload.request_type_id
    end
    counted = grouped_payloads.map do |key, value|
      [value.count, RequestType.find_by(id: key)]
    end.sort.reverse
    result = counted.map do |array|
      array[1].verb
    end.first
  end

end
