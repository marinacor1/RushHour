class Url < ActiveRecord::Base

  def self.sort_url_requests
    # make a count of how many times each url is requested

    # then return a list that is sorted by the count
    url_count = self.select(:address).group(:address).having("count(*) > 0").count
    url_count.sort_by do |k, v|
      v
    end.reverse
  end


end
