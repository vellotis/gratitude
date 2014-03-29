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

    def bitbucket_api_url
      response_body["elsewhere"]["bitbucket"]
    end
    alias_method :bitbucket, :bitbucket_api_url

    def bitbucket_username
      if bitbucket_api_url
        bitbucket_api_url.gsub("https://bitbucket.org/api/1.0/users/", "")
      end
    end

    def bountysource_api_url
      response_body["elsewhere"]["bountysource"]
    end
    alias_method :bountysource, :bountysource_api_url

    def bountysource_username
      if bountysource_api_url
        bountysource_api_url.gsub("https://api.bountysource.com/users/", "")
      end
    end

    def github_api_url
      response_body["elsewhere"]["github"]
    end
    alias_method :github, :github_api_url

    def github_username
      if github_api_url
        github_api_url.gsub("https://api.github.com/users/", "")
      end
    end

    def twitter_api_url
      response_body["elsewhere"]["twitter"]
    end
    alias_method :twitter, :twitter_api_url

    def twitter_username
      nil
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

    private

    def response
      @response ||= faraday.get("/#{username}/public.json")
    end

    def response_body
      @response_body ||= response.body
    end
  end # Profile
end # Gratitude
