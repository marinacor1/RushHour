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
      erb :show_client
    end

    get '/sources/:IDENTIFIER/urls/:RELATIVEPATH' do |id|
      client = Client.find_by(identifier: id)
      payloads = PayloadRequest.where(client_id: client.id)
      @urls = payloads.map {|payload| Url.where(id: payload.url_id)}.flatten
      erb :show_url
    end

  end
end
