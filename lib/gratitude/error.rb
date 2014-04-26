module Gratitude
  class UsernameNotFoundError < StandardError
    def initialize(username)
      super("The requested username, '#{username}', could not be found. Please be aware that Gittip API requests are case sensitive.")
    end
  end
end
