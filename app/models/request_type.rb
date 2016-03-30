class RequestType < ActiveRecord::Base

  def self.list_verbs


    # verb_count = self.select(:verb).group(:verb).having("count(*) > 0").count
    # verb_count.sort_by do |verb, count|
    #   count
    # end.reverse.map { |verb, count| verb }
  end

  def self.most_requested
    # since list_verbs returns a descending list to pick most
    # requested just need to take the first one in the list
    self.list_verbs[0]
  end

end
