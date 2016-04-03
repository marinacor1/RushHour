module ServerMethods

  def find_client_from_url(id)
    Client.find_by(identifier: id)
  end

  def no_payloads_sent_by?(client)
    PayloadRequest.find_by(client_id: client.id).nil?
  end

  def path_does_not_exist?(id, path)
    client = find_client_from_url(id)
    target_path = client.root_url + "/" + path
    @url = Url.where(address: target_path).first
    @url.nil?
  end

  def event_payloads(id, event)
    client = find_client_from_url(id)
    PayloadRequest.where(client_id: client.id, event_name: event )
  end

  def parse_times_of(payloads)
    hour_collection = payloads.map do |payload|
      payload.param.split[1].split(":")[0]
    end
    hour_count = hour_collection.group_by {|h| h}
    hour_count.map {|k, v| hour_count[k] = v.count}
    hour_count.default = "0"
    hour_count
  end
end
