module RushHour
  class Server < Sinatra::Base
    attr_reader :helper
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
      @helper = PayloadHelper.new(params)
      status, body = @helper.returned
    end

    get '/sources/:IDENTIFIER' do |id|
      client = Client.find_by(identifier: id)
      payload = PayloadRequest.find_by(client_id: client.id)
      @url = Url.find_by(id: payload.url_id)
      erb :show
    end

  end
end
