class User < ActiveRecord::Base

    def self.browser_breakdown
      self.all.map do |info|
        "#{info.browser}"
      end
    end

    def self.os_breakdown
      self.all.map do |info|
        "#{info.os}"
      end
    end
end
