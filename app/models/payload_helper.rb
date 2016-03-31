require 'json'
class PayloadHelper

  def initialize(params, id)
    create_payload_requests(parse(params))
  end

  def parse(params)
    JSON.parse(params["payload"])
  end

  def create_payload_requests(params)
    # binding.pry
    PayloadRequest.create({url_id: Url.find_or_create_by(address: params["url"]).id,
                      requested_at: params["requestedAt"],
                      responded_in: params["respondedIn"],
                      referrer_id: Referrer.find_or_create_by(referred_by: params["referredBy"]).id,
                      request_type_id: RequestType.find_or_create_by(verb: params["requestType"]).id,
                      event_name: params["eventName"],
                      user_id: User.find_or_create_by(browser: UserAgent.parse(params["userAgent"]).browser,
                      os: UserAgent.parse(params["userAgent"]).platform).id,
                      display_id: Display.find_or_create_by(width: params["resolutionWidth"], height: params["resolutionHeight"]).id,
                      ip: params["ip"]
                      })
    # Hash.new(0) {:url =>
    # :requested_at => params["requestedAt"]}
  end
end
