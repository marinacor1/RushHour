module RushHour
  class Server < Sinatra::Base
    not_found do
      erb :error
    end

    post '/sources' do
      client = Client.find_or_create_by(identifier: params["client"][:identifier],
                               root_url: params["client"][:rootUrl] )
    end


  end
end
