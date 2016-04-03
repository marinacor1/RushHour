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

end
