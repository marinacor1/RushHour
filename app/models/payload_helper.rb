require 'json'
class PayloadHelper
  attr_accessor :payload
  attr_reader :returned

  def initialize(params)
    if params.nil?
      @params = {}
    else
      @params = params
    end
    @client = params["id"]
    payload = create_payload_requests(parse(params))
    # return_status(payload)
  end

  def parse(params)
    unless @params["payload"].nil?
      JSON.parse(params["payload"])
    end
  end

  def create_payload_requests(params_hash)
    payload = PayloadRequest.new({url_id: Url.find_or_create_by(address: params_hash["url"]).id,
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
    if payload.save
      @returned = [200, "happy"]
    # elsif !Client.find_by(:identifier == @client)
    #   @returned = [400, payload.errors.full_messages.join(" ,")]
    # elsif @params.nil?
    #   @returned = [403, payload.errors.full_messages.join(" ,")]
    #if payloadrequest has an entry with matching params return 403
    elsif PayloadRequest.where(param: @params)
      @returned = [403, payload.errors.full_messages.join(" ,")]
    end
    # if @params["payload"].nil?
    #   @payload = nil
    # elsif !Client.find_by(:identifier == @client)
    #   @payload = :unknown_client
    # else
      # payload.update_attributes({url_id: Url.find_or_create_by(address: params_hash["url"]).id,
      #   requested_at: params_hash["requestedAt"],
      #   responded_in: params_hash["respondedIn"],
      #   referrer_id: Referrer.find_or_create_by(referred_by: params_hash["referredBy"]).id,
      #   request_type_id: RequestType.find_or_create_by(verb: params_hash["requestType"]).id,
      #   event_name: params_hash["eventName"],
      #   user_id: User.find_or_create_by(browser: UserAgent.parse(params_hash["userAgent"]).browser,
      #   os: UserAgent.parse(params_hash["userAgent"]).platform).id,
      #   display_id: Display.find_or_create_by(width: params_hash["resolutionWidth"], height: params_hash["resolutionHeight"]).id,
      #   ip: params_hash["ip"],
      #   client_id: Client.find_by(:identifier == @client).id,
      #   param: "#{@params}"
      #   })
  end

  # def return_status(payload)
  #   payload.show_status
  # end

end
