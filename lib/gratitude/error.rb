# encoding: utf-8

module Gratitude
  class UsernameNotFoundError < StandardError
    def initialize(username)
      super(
        "The requested username, '#{username}', could not be found."\
        "Please note that Gittip API requests are case sensitive.")
    end
  end

  class AuthenticationError < StandardError
    def initialize
      super(
        "The supplied username and api_key could not properly authenticate "\
        "with Gittip.")
    end
  end

  class TipUpdateError < StandardError
    def initialize(usernames)
      combined_usernames = usernames.join(", ")
      super(
      "There was an error updating the tip(s) for the following user(s): "\
      "#{combined_usernames}.")
    end
  end
end
