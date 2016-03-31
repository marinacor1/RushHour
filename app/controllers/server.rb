module RushHour
  class Server < Sinatra::Base
    not_found do
      erb :error
    end

    post '/sources' do
      client = Client.new(identifier: params["client"][:identifier], root_url: params["client"][:rootUrl] ) unless params.empty?
      if client.save
        status 200
      else
        status 400
      end
    end

  end
end
