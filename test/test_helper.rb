require 'simplecov'
SimpleCov.start

ENV["RACK_ENV"] ||= "test"

require 'bundler'
Bundler.require

require File.expand_path("../../config/environment", __FILE__)
require 'minitest/autorun'
require 'minitest/pride'
require 'capybara/dsl'
require "database_cleaner"
require 'pry'
require 'tilt/erb'

Capybara.app = RushHour::Server

DatabaseCleaner.strategy = :truncation, {except: %w[public.schema_migrations]}

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

    PayloadRequest.create({ url_id: Url.find_or_create_by(address: "http://jumpstartlab.com/").id,
                            requested_at: "2013-02-16 21:38:28 -0700",
                            responded_in: 37,
                            referrer_id: Referrer.find_or_create_by(referred_by:"http://jumpstartlab.com").id,
                            request_type_id: RequestType.find_or_create_by(verb: "GET").id,
                            event_name: "socialLogin",
                            user_id: User.find_or_create_by(browser: UserAgent.parse("Safari/537.17").browser,
                                                 os: UserAgent.parse("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17").platform
                                                 ).id,
                            display_id: Display.find_or_create_by(width: "1920", height: "1280").id,
                            ip: "63.29.38.211",
                            client_id: 1,
                            param: "1"
                          })

    PayloadRequest.create({ url_id: Url.find_or_create_by(address: "http://jumpstartlab.com/").id,
                            requested_at: "2013-02-16 21:38:28 -0700",
                            responded_in: 37,
                            referrer_id: Referrer.find_or_create_by(referred_by:"http://askjeeves.com").id,
                            request_type_id: RequestType.find_or_create_by(verb: "GET").id,
                            event_name: "socialLogin",
                            user_id: User.find_or_create_by(browser: UserAgent.parse("Safari/537.17").browser,
                                                 os: UserAgent.parse("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17").platform
                                                 ).id,
                            display_id: Display.find_or_create_by(width: "120", height: "180").id,
                            ip: "63.29.38.211",
                            client_id: 1,
                            param: "2"
                          })

    PayloadRequest.create({ url_id: Url.find_or_create_by(address: "http://turing.io/").id,
                            requested_at: "2014-02-16 21:38:28 -0700",
                            responded_in: 90,
                            referrer_id: Referrer.find_or_create_by(referred_by:"http://google.com").id,
                            request_type_id: RequestType.find_or_create_by(verb: "POST").id,
                            event_name: "passwordEntry",
                            user_id: User.find_or_create_by(browser: UserAgent.parse("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Opera/24.0.1309.0 Safari/537.17").browser,
                                                 os: UserAgent.parse("Mozilla/5.0 (Linux; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17").platform
                                                 ).id,
                            display_id: Display.find_or_create_by(width: "9000", height: "9000").id,
                            ip: "99.99.99.9999",
                            param: "3"
                          })

    PayloadRequest.create({ url_id: Url.find_or_create_by(address: "http://yahoo.com/").id,
                            requested_at: "2015-02-16 21:38:28 -0700",
                            responded_in: 100,
                            referrer_id: Referrer.find_or_create_by(referred_by:"http://junglejuice.com").id,
                            request_type_id: RequestType.find_or_create_by(verb: "DELETE").id,
                            event_name: "lastentry",
                            user_id: User.find_or_create_by(browser: UserAgent.parse("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Safari/24.0.1309.0 Safari/537.17").browser,
                                                 os: UserAgent.parse("Mozilla/5.0 (Windows; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17").platform
                                                 ).id,
                            display_id: Display.find_or_create_by(width: "4000", height: "4000").id,
                            ip: "10.00.00.000",
                            param: "4"
                          })
    PayloadRequest.create({ url_id: Url.find_or_create_by(address: "http://jumpstartlab.com/").id,
                            requested_at: "2013-02-16 21:38:28 -0700",
                            responded_in: 37,
                            referrer_id: Referrer.find_or_create_by(referred_by:"http://jumpstartlab.com").id,
                            request_type_id: RequestType.find_or_create_by(verb: "GET").id,
                            event_name: "socialLogin",
                            user_id: User.find_or_create_by(browser: UserAgent.parse("Intel Mac OS X 10_8_2) Netscape/537.17 (KHTML, like Gecko) Netscape/24.0.1309.0 Netscape/537.17").browser,
                                                 os: UserAgent.parse("Mozilla/5.0 (Windows; Intel Mac OS X 10_8_2) ").platform
                                                 ).id,
                            display_id: Display.find_or_create_by(width: "192", height: "128").id,
                            ip: "63.29.38.211",
                            client_id: 1,
                            param: "5"
                          })

    PayloadRequest.create({ url_id: Url.find_or_create_by(address: "http://jumpstartlab.com/").id,
                            requested_at: "2013-02-16 21:38:28 -0700",
                            responded_in: 37,
                            referrer_id: Referrer.find_or_create_by(referred_by:"http://jumpstartlab.com").id,
                            request_type_id: RequestType.find_or_create_by(verb: "GET").id,
                            event_name: "socialLogin",
                            user_id: User.find_or_create_by(browser: UserAgent.parse("Intel Mac OS X 10_8_2) Netscape/537.17 (KHTML, like Gecko) Netscape/24.0.1309.0 Netscape/537.17").browser,
                                                 os: UserAgent.parse("Mozilla/5.0 (Windows; Intel Mac OS X 10_8_2) ").platform
                                                 ).id,
                            display_id: Display.find_or_create_by(width: "120", height: "1280").id,
                            client_id: 1,
                            ip: "63.29.38.211",
                            param: "6"
                          })

    PayloadRequest.create({ url_id: Url.find_or_create_by(address: "http://jumpstartlab.com/").id,
                            requested_at: "2013-02-16 21:38:28 -0700",
                            responded_in: 37,
                            referrer_id: Referrer.find_or_create_by(referred_by:"http://jumpstartlab.com").id,
                            request_type_id: RequestType.find_or_create_by(verb: "GET").id,
                            event_name: "socialLogin",
                            user_id: User.find_or_create_by(browser: UserAgent.parse("Safari/537.17").browser,
                                                 os: UserAgent.parse("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17").platform
                                                 ).id,
                            display_id: Display.find_or_create_by(width: "1920", height: "1280").id,
                            client_id: 1,
                            ip: "63.29.38.211",
                            param: "7"
                          })

    PayloadRequest.create({ url_id: Url.find_or_create_by(address: "http://jumpstartlab.com/").id,
                            requested_at: "2013-02-16 21:38:28 -0700",
                            responded_in: 37,
                            referrer_id: Referrer.find_or_create_by(referred_by:"http://google.com").id,
                            request_type_id: RequestType.find_or_create_by(verb: "GET").id,
                            event_name: "socialLogin",
                            user_id: User.find_or_create_by(browser: UserAgent.parse("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko)").browser,
                                                 os: UserAgent.parse("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17").platform
                                                 ).id,
                            display_id: Display.find_or_create_by(width: "190", height: "123").id,
                            client_id: 1,
                            ip: "63.29.38.211",
                            param: "8"
                          })

    PayloadRequest.create({ url_id: Url.find_or_create_by(address: "http://jumpstartlab.com/").id,
                            requested_at: "2013-02-16 21:38:28 -0700",
                            responded_in: 37,
                            referrer_id: Referrer.find_or_create_by(referred_by:"http://google.com").id,
                            request_type_id: RequestType.find_or_create_by(verb: "GET").id,
                            event_name: "socialLogin",
                            user_id: User.find_or_create_by(browser: UserAgent.parse("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17").browser,
                                                 os: UserAgent.parse("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17").platform
                                                 ).id,
                            display_id: Display.find_or_create_by(width: "1920", height: "1280").id,
                            client_id: 1,
                            ip: "63.29.38.211",
                            param: "9"
                          })

    PayloadRequest.create({ url_id: Url.find_or_create_by(address: "http://jumpstartlab.com/").id,
                            requested_at: "2013-02-16 21:38:28 -0700",
                            responded_in: 37,
                            referrer_id: Referrer.find_or_create_by(referred_by:"http://bing.com").id,
                            request_type_id: RequestType.find_or_create_by(verb: "GET").id,
                            event_name: "socialLogin",
                            user_id: User.find_or_create_by(browser: UserAgent.parse("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17").browser,
                                                 os: UserAgent.parse("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17").platform
                                                 ).id,
                            display_id: Display.find_or_create_by(width: "1920", height: "1280").id,
                            ip: "63.29.38.211",
                            client_id: 1,
                            param: "10"
                          })
    PayloadRequest.create({ url_id: Url.find_or_create_by(address: "http://turing.io/").id,
                            requested_at: "2014-02-16 21:38:28 -0700",
                            responded_in: 100,
                            referrer_id: Referrer.find_or_create_by(referred_by:"http://google.com").id,
                            request_type_id: RequestType.find_or_create_by(verb: "PUT").id,
                            event_name: "passwordEntry",
                            user_id: User.find_or_create_by(browser: UserAgent.parse("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Opera/24.0.1309.0 Safari/537.17").browser,
                                                 os: UserAgent.parse("Mozilla/5.0 (Linux; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17").platform
                                                 ).id,
                            display_id: Display.find_or_create_by(width: "9000", height: "9000").id,
                            ip: "99.99.99.9999",
                            param: "11"
                          })

    PayloadRequest.create({ url_id: Url.find_or_create_by(address: "http://turing.io/").id,
                            requested_at: "2014-02-16 21:38:28 -0700",
                            responded_in: 100,
                            referrer_id: Referrer.find_or_create_by(referred_by:"http://google.com").id,
                            request_type_id: RequestType.find_or_create_by(verb: "POST").id,
                            event_name: "passwordEntry",
                            user_id: User.find_or_create_by(browser: UserAgent.parse("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Opera/24.0.1309.0 Safari/537.17").browser,
                                                 os: UserAgent.parse("Mozilla/5.0 (Linux; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17").platform
                                                 ).id,
                            display_id: Display.find_or_create_by(width: "9000", height: "9000").id,
                            ip: "99.99.99.9999",
                            param: "12"
                          })

    PayloadRequest.create({ url_id: Url.find_or_create_by(address: "http://turing.io/").id,
                            requested_at: "2014-02-16 21:38:28 -0700",
                            responded_in: 100,
                            referrer_id: Referrer.find_or_create_by(referred_by:"http://google.com").id,
                            request_type_id: RequestType.find_or_create_by(verb: "POST").id,
                            event_name: "passwordEntry",
                            user_id: User.find_or_create_by(browser: UserAgent.parse("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Opera/24.0.1309.0 Safari/537.17").browser,
                                                 os: UserAgent.parse("Mozilla/5.0 (Linux; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17").platform
                                                 ).id,
                            display_id: Display.find_or_create_by(width: "9000", height: "9000").id,
                            ip: "99.99.99.9999",
                            param: "13"
                          })

    PayloadRequest.create({ url_id: Url.find_or_create_by(address: "http://turing.io/").id,
                            requested_at: "2014-02-16 21:38:28 -0700",
                            responded_in: 10,
                            referrer_id: Referrer.find_or_create_by(referred_by:"http://google.com").id,
                            request_type_id: RequestType.find_or_create_by(verb: "POST").id,
                            event_name: "passwordEntry",
                            user_id: User.find_or_create_by(browser: UserAgent.parse("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Opera/24.0.1309.0 Safari/537.17").browser,
                                                 os: UserAgent.parse("Mozilla/5.0 (Linux; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17").platform
                                                 ).id,
                            display_id: Display.find_or_create_by(width: "9000", height: "9000").id,
                            ip: "99.99.99.9999",
                            param: "14"
                          })

    PayloadRequest.create({ url_id: Url.find_or_create_by(address: "http://jumpstartlab.com/").id,
                            requested_at: "2013-02-16 21:38:28 -0700",
                            responded_in: 7,
                            referrer_id: Referrer.find_or_create_by(referred_by:"http://jumpstartlab.com").id,
                            request_type_id: RequestType.find_or_create_by(verb: "POST").id,
                            event_name: "socialLogin",
                            user_id: User.find_or_create_by(browser: UserAgent.parse("Aetscape/5.0 (Macintosh; Intel Mac OS X 10_8_2) Aetscape/537.17 (KHTML, like Gecko) Aetscape/24.0.1309.0 Aetscape/537.17").browser,
                                                 os: UserAgent.parse("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17").platform
                                                 ).id,
                            client_id: 1,
                            display_id: Display.find_or_create_by(width: "1920", height: "1280").id,
                            ip: "63.29.38.211",
                            param: "15"
                          })
  end

  def single_payload
    PayloadRequest.create({ url_id: Url.find_or_create_by(address: "http://jumpstartlab.com/").id,
                            requested_at: "2013-02-16 21:38:28 -0700",
                            responded_in: 7,
                            referrer_id: Referrer.find_or_create_by(referred_by:"http://jumpstartlab.com").id,
                            request_type_id: RequestType.find_or_create_by(verb: "GET").id,
                            event_name: "socialLogin",
                            user_id: User.find_or_create_by(browser: UserAgent.parse("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17").browser,
                                                 os: UserAgent.parse("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17").platform
                                                 ).id,
                            display_id: Display.find_or_create_by(width: "1920", height: "1280").id,
                            client_id: 1,
                            ip: "63.29.38.211",
                            param: "16"
                          })
  end

  def single_turing_payload
    PayloadRequest.create({ url_id: Url.find_or_create_by(address: "http://turing.io/").id,
                            requested_at: "2013-02-16 21:38:28 -0700",
                            responded_in: 7,
                            referrer_id: Referrer.find_or_create_by(referred_by:"http://google.com").id,
                            request_type_id: RequestType.find_or_create_by(verb: "GET").id,
                            event_name: "socialLogin",
                            user_id: User.find_or_create_by(browser: UserAgent.parse("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17").browser,
                                                 os: UserAgent.parse("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17").platform
                                                 ).id,
                            display_id: Display.find_or_create_by(width: "1920", height: "1280").id,
                            ip: "63.29.38.211",
                            param: "17"
                          })
  end

end
