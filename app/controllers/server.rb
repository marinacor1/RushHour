module RushHour
  class Server < Sinatra::Base

    not_found do
      erb :error
    end

    post '/sources' do
      client = Client.new(identifier: params[:identifier], root_url: params[:rootUrl] )
      if client.save
        status 200
        body "identifier: #{client.identifier}"
      elsif Client.find_by(:identifier == params[:identifier])
        status 403
        body client.errors.full_messages.join(", ")
      else
        status 400
        body client.errors.full_messages.join(", ")
      end
      # returned_info = [200, "The body"]
      # client_parser = ClientParser.new(params)
      #
      # status, body = client_parser
    end

    post '/sources/:id/data' do |id|
      helper = PayloadHelper.new(params)
      status, body = helper.returned
    end

    get '/sources/:id' do |id|
      client = Client.find_by(identifier: id)
      payloads = PayloadRequest.where(client_id: client.id)
      @urls = payloads.map {|payload| Url.where(id: payload.url_id)}.flatten
      erb :show
    end

  end
end
