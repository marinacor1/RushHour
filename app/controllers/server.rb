require_relative "../models/server_methods"

module RushHour
  class Server < Sinatra::Base

    include ServerMethods

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
      client = find_client_from_url(id)
      if client.nil?
        erb :client_error
      elsif no_payloads_sent_by?(client)
        erb :payload_error
      else
        erb :show_client
      end
    end

    get '/sources/:id/urls/:path' do |id, path|
      if path_does_not_exist?
        binding.pry
        @identifier = id
        erb :url_error
      else
        erb :show_url
      end
    end

    get '/sources/:id/events/:event' do |id, event|
      payloads = event_payloads(id, event)
      if payloads.empty?
        @identifier = id
        erb :event_error
      else
        @total = payloads.count
        @hour_count = parse_times_of(payloads)
        @event = event
        erb :show_event
      end
    end
  end
end
