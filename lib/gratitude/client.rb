# encoding: utf-8

require "gratitude/connection"
require "gratitude/tips"

module Gratitude
  class Client
    include Gratitude::Connection
    include Gratitude::Client::Tips

    attr_reader :username, :api_key

    def initialize(options = {})
      @username = options[:username]
      @api_key = options[:api_key]
      faraday.basic_auth(api_key, "")
    end
  end # Payday
end # Gratitude
