# encoding: utf-8

module Gratitude
  class Profile
    include Connection
    attr_reader :username

    def initialize(username)
      @username = username
    end

    %w(
      avatar
      elsewhere
      id
      npatrons
      number
      on
    ).each do |response_key|
      define_method(response_key) { response_body.fetch(response_key) }
    end

    alias_method :avatar_url, :avatar
    alias_method :account_type, :number
    alias_method :number_of_patrons, :npatrons

    def giving
      response_body.fetch("giving").to_f
    end
    alias_method :amount_giving, :giving

    def amount_receiving
      response_body.fetch("receiving").to_f
    end
    alias_method :receiving, :amount_receiving

    def goal
      response_body.fetch("goal").to_f if response_body["goal"]
    end

    def bitcoin
      response_body.fetch("bitcoin") { nil }
    end

    %w(
      bitbucket
      bountysource
      github
      openstreetmap
      twitter
      venmo
    ).each do |other_account|
      define_method(other_account) { elsewhere[other_account] }

      define_method("#{other_account}_username") do
        if send(other_account.to_sym)
          send(other_account.to_sym).fetch("user_name")
        end
      end
    end

    private

    def response
      @response ||= faraday.get("/#{username}/public.json")
      raise UsernameNotFoundError, username if @response.status == 406
      @response
    end

    def response_body
      @response_body ||= response.body
    end
  end # Profile
end # Gratitude
