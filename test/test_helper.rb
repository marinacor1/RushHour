ENV["RACK_ENV"] ||= "test"

require 'bundler'
Bundler.require

require File.expand_path("../../config/environment", __FILE__)
require 'minitest/autorun'
require 'minitest/pride'
require 'capybara/dsl'
require "database_cleaner"
require 'pry'

Capybara.app = RushHour::Server

DatabaseCleaner.strategy = :truncation, {except: %w[public.schema_migrations]}

# copied directly from readme to DatabaseCleaner gem
class Minitest::Spec
  before :each do
    DatabaseCleaner.start
  end

  after :each do
    DatabaseCleaner.clean
  end
end

module TestHelpers

  def create_payloads

    PayloadRequest.create({ url_id: Url.create(address: "http://jumpstartlab.com/").id,
                            requested_at: "2013-02-16 21:38:28 -0700",
                            responded_in: 37,
                            request_id: Request.create(referred_by:"http://jumpstartlab.com").id,
                            request_type_id: RequestType.create(verb: "GET").id,
                            event_name: "socialLogin",
                            user_id: User.create(browser: UserAgent.parse("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17").browser,
                                                 os: UserAgent.parse("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17").platform
                                                 ).id,
                            display_id: Display.create(width: "1920", height: "1280").id,
                            ip: "63.29.38.211"
                          })

    PayloadRequest.create({ url_id: Url.create(address: "http://jumpstartlab.com/").id,
                            requested_at: "2013-02-16 21:38:28 -0700",
                            responded_in: 37,
                            request_id: Request.create(referred_by:"http://jumpstartlab.com").id,
                            request_type_id: RequestType.create(verb: "GET").id,
                            event_name: "socialLogin",
                            user_id: User.create(browser: UserAgent.parse("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17").browser,
                                                 os: UserAgent.parse("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17").platform
                                                 ).id,
                            display_id: Display.create(width: "1920", height: "1280").id,
                            ip: "63.29.38.211"
                          })

    PayloadRequest.create({ url_id: Url.create(address: "http://turing.io/").id,
                            requested_at: "2014-02-16 21:38:28 -0700",
                            responded_in: 90,
                            request_id: Request.create(referred_by:"http://google.com").id,
                            request_type_id: RequestType.create(verb: "POST").id,
                            event_name: "passwordEntry",
                            user_id: User.create(browser: UserAgent.parse("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Opera/24.0.1309.0 Safari/537.17").browser,
                                                 os: UserAgent.parse("Mozilla/5.0 (Linux; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17").platform
                                                 ).id,
                            display_id: Display.create(width: "9000", height: "9000").id,
                            ip: "99.99.99.9999"
                          })

    PayloadRequest.create({ url_id: Url.create(address: "http://yahoo.com/").id,
                            requested_at: "2015-02-16 21:38:28 -0700",
                            responded_in: 100,
                            request_id: Request.create(referred_by:"http://junglejuice.com").id,
                            request_type_id: RequestType.create(verb: "DELETE").id,
                            event_name: "lastentry",
                            user_id: User.create(browser: UserAgent.parse("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Safari/24.0.1309.0 Safari/537.17").browser,
                                                 os: UserAgent.parse("Mozilla/5.0 (Windows; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17").platform
                                                 ).id,
                            display_id: Display.create(width: "4000", height: "4000").id,
                            ip: "10.00.00.000"
                          })



    end
end
