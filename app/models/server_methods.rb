module ServerMethods

  def find_client_from_url(id)
    Client.find_by(identifier: id)
  end

end
