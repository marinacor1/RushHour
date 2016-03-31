require 'json'
class PayloadHelper

  def initialize(params, id)
    parse(params)

    # binding.pry
  end

  def parse(params)
    JSON.parse(params["payload"])
  end
end
