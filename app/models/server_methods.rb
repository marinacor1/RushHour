module ServerMethods

  def find_client_from_url(id)
    Client.find_by(identifier: id)
  end

  def no_payloads_sent_by?(client)
    PayloadRequest.find_by(client_id: client.id).nil?
  end

end
