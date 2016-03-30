class RequestType < ActiveRecord::Base

  def self.list_verbs
    # verb_count is a hash with key = verb, value = count of key
    verb_count = self.select(:verb).group(:verb).having("count(*) > 0").count
    # sort_by the count + reverse returns list of verbs in descending order of count
    # might need to do a better job of using sql here
    verb_count.sort_by do |verb, count|
      count
    end.reverse.map { |verb, count| verb }
  end

  def self.most_requested
    # since list_verbs returns a descending list to pick most
    # requested just need to take the first one in the list
    self.list_verbs[0]
  end

end
