class Display < ActiveRecord::Base

  def self.screen_resolutions
    self.all.map do |display|
      "#{display.width} x #{display.height}"
    end
  end
end
