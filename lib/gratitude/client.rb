require "gratitude/tips"

module Gratitude
  class Client
    include HTTParty
    include Gratitude::Client::Tips

    attr_reader :username, :api_key

    def initialize(options = {})
      @username = options[:username]
      @api_key = options[:api_key]
    end

  end # Payday
end # Gratitude