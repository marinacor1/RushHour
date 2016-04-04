require 'json'
class ClientHelper
  attr_reader :returned

  def initialize(params)
    client = Client.new(identifier: params["identifier"], root_url: params["rootUrl"])
    if client.save
      @returned = [200, "identifier: #{client.identifier}"]
    elsif Client.find_by(:identifier == params[:identifier])
      @returned = [403, client.errors.full_messages.join(", ")]
    else
      @returned = [400, client.errors.full_messages.join(", ")]
    end
  end
end
