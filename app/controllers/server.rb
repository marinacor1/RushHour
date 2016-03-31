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
        error = body client.errors.full_messages.join(", ")
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
      formatted = PayloadHelper.new(params, id)
      # Parser.parse(params, id)
      #inside parser generate hash from arguments
      #assign hash keys to table row names
      #use hash create payload request
      PayloadRequest.create(formatted)
      #return status and body
    end

  end
end
