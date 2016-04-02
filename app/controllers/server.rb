module RushHour
  class Server < Sinatra::Base

    not_found do
      erb :error
    end

    post '/sources' do
      client = ClientHelper.new(params)
      status, body = client.returned
    end

    post '/sources/:id/data' do |id|
      helper = PayloadHelper.new(params)
      status, body = helper.returned
    end

    get '/sources/:id' do |id|
      @client = Client.find_by(identifier: id)
      if @client.nil?
        erb :client_error
      elsif PayloadRequest.find_by(client_id: @client.id).nil?
        erb :payload_error
      else
        erb :show_client
      end
    end

    get '/sources/:id/urls/:path' do |id, path|
      client = Client.find_by(identifier: id)
      target_path = client.root_url + "/" + path
      @url = Url.where(address: target_path).first
      if @url.nil?
        erb :url_error
      else
        erb :show_url
      end
    end

  end
end
