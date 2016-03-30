class User < ActiveRecord::Base

    def self.browser_breakdown
      self.all.map do |info|
        "#{info.browser}"
      end
    end
end
