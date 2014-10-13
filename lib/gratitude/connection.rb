# encoding: utf-8

module Gratitude
  module Connection
    def faraday
      @faraday ||= Faraday.new(url: "https://gratipay.com/") do |faraday|
        faraday.response :json, content_type: /\bjson$/
        faraday.adapter Faraday.default_adapter
      end
    end
  end
end
