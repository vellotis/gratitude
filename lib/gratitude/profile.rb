module Gratitude
  class Profile
    include HTTParty
    base_uri "https://www.gittip.com"
    URI_SUFFIX = "/public.json"

    attr_reader :username, :response

    def initialize(username)
      @username = username
      @response = self.class.get("/#{username}#{URI_SUFFIX}")
    end

    def avatar_url
      response["avatar"]
    end

    def bitbucket_api_url
      response["elsewhere"]["bitbucket"]
    end

    def bitbucket_username
      bitbucket_api_url.gsub("https://bitbucket.org/api/1.0/users/", "") if bitbucket_api_url
    end

    def bountysource_api_url
      response["elsewhere"]["bountysource"]
    end

    def bountysource_username
      bountysource_api_url.gsub("https://api.bountysource.com/users/", "") if bountysource_api_url
    end

    def github_api_url
      response["elsewhere"]["github"]
    end

    def github_username
      github_api_url.gsub("https://api.github.com/users/", "") if github_api_url
    end

    def twitter_api_url
      response["elsewhere"]["twitter"]
    end

    def twitter_username
      nil
    end

    def amount_giving
      response["giving"].to_f
    end

    def amount_receiving
      response["receiving"].to_f
    end

    def goal
      response["goal"].to_f if response["goal"]
    end

    def number
      response["number"]
    end

    def id
      response["id"]
    end

  end # Profile
end # Gratitude
