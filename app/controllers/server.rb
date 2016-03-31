module RushHour
  class Server < Sinatra::Base
    not_found do
      erb :error
    end

    post '/sources' do
      client = Client.new(identifier: params[:identifier], root_url: params[:rootUrl] )
      if client.save
        status 200
        body
      else
        status 400
        #body client.errors.full_messages.join(", ")
      end
      # returned_info = [200, "The body"]
      # client_parser = ClientParser.new(params)
      #
      # status, body = client_parser
    end

  end
end
