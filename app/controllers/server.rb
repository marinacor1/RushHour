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

    get '/sources/:id/events/:event' do |id, event|
      @event = event
      client_id = Client.find_by(identifier: id).id
      event_payloads = PayloadRequest.where(client_id: client_id, event_name: event )
      hour_collection = event_payloads.map do |payload|
        payload.param.split[1].split(":")[0]
      end
      @hour_count = hour_collection.group_by {|h| h}
      @hour_count.map {|k,v| @hour_count[k] = v.count}
      @hour_count.default = "0"
        erb :show_event
    end

  end
end
