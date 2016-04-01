require 'json'
class PayloadHelper
  attr_accessor :payload

  def initialize(params)
    @params = params
    @client = params["id"]
    create_payload_requests(parse(params))
  end

  def parse(params)
    unless @params["payload"].nil?
      JSON.parse(params["payload"])
    end
  end

  def create_payload_requests(params_hash)
    if @params["payload"].nil?
      @payload = nil
    elsif !Client.find_by(:identifier == @client)
      @payload = :unknown_client
    else
      @payload = PayloadRequest.new({url_id: Url.find_or_create_by(address: params_hash["url"]).id,
                        requested_at: params_hash["requestedAt"],
                        responded_in: params_hash["respondedIn"],
                        referrer_id: Referrer.find_or_create_by(referred_by: params_hash["referredBy"]).id,
                        request_type_id: RequestType.find_or_create_by(verb: params_hash["requestType"]).id,
                        event_name: params_hash["eventName"],
                        user_id: User.find_or_create_by(browser: UserAgent.parse(params_hash["userAgent"]).browser,
                        os: UserAgent.parse(params_hash["userAgent"]).platform).id,
                        display_id: Display.find_or_create_by(width: params_hash["resolutionWidth"], height: params_hash["resolutionHeight"]).id,
                        ip: params_hash["ip"],
                        client_id: Client.find_by(:identifier == @client).id,
                        param: "#{@params}"
                        })
    end
  end
end
