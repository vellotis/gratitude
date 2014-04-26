module Gratitude
  class Profile
    include Connection
    attr_reader :username

    def initialize(username)
      @username = username
    end

    def avatar_url
      response_body["avatar"]
    end
    alias_method :avatar, :avatar_url

    def bitcoin
      response_body["bitcoin"]
    end

    def bitbucket
      response_body["elsewhere"]["bitbucket"]
    end

    def bitbucket_username
      bitbucket["user_name"] if bitbucket
    end

    def bountysource
      response_body["elsewhere"]["bountysource"]
    end

    def bountysource_username
      bountysource["user_name"] if bountysource
    end

    def github
      response_body["elsewhere"]["bountysource"]
    end

    def github_username
      github["user_name"] if github
    end

    def openstreetmap
      response_body["elsewhere"]["openstreetmap"]
    end

    def openstreetmap_username
      openstreetmap["user_name"] if openstreetmap
    end

    def twitter
      response_body["elsewhere"]["twitter"]
    end

    def twitter_username
      twitter["user_name"] if twitter
    end

    def venmo
      response_body["elsewhere"]["venmo"]
    end

    def venmo_username
      venmo["user_name"] if venmo
    end

    def amount_giving
      response_body["giving"].to_f
    end
    alias_method :giving, :amount_giving

    def amount_receiving
      response_body["receiving"].to_f
    end
    alias_method :receiving, :amount_receiving

    def goal
      response_body["goal"].to_f if response_body["goal"]
    end

    def account_type
      response_body["number"]
    end
    alias_method :number, :account_type

    def id
      response_body["id"]
    end

    def number_of_patrons
      response_body["npatrons"]
    end
    alias_method :npatrons, :number_of_patrons

    def on
      response_body["on"]
    end

    private

    def response
      @response ||= faraday.get("/#{username}/public.json")
      raise UsernameNotFoundError.new(username) if @response.status == 406
      @response
    end

    def response_body
      @response_body ||= response.body
    end

  end # Profile
end # Gratitude
