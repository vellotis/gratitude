# encoding: utf-8

module Gratitude
  class UserChart
    extend Connection
    USER_CHARTS = []

    attr_reader :username, :date, :number_of_patrons, :receipts
    alias_method :npatrons, :number_of_patrons

    def initialize(options = {})
      @username = options["username"]
      @date = Date.parse(options["date"]) if options["date"]
      @number_of_patrons = options["npatrons"]
      @receipts = options["receipts"]
      USER_CHARTS << self
    end

    def self.all_for_user(username)
      USER_CHARTS.clear if user_charts_contains_other_usernames?(username)
      collect_charts_for(username) if USER_CHARTS.empty?
      USER_CHARTS
    end

    def self.newest_for(username)
      sort_by_date_for_user(username).first
    end

    def self.oldest_for(username)
      sort_by_date_for_user(username).last
    end

    def self.sort_by_date_for_user(username)
      all_for_user(username).sort_by(&:date).reverse
    end

    def self.user_charts_contains_other_usernames?(username)
      USER_CHARTS.collect(&:username).uniq != [username]
    end

    def self.user_charts_from_gratipay(username)
      response = faraday.get("/#{username}/charts.json").body.to_a
      raise UsernameNotFoundError, username if response.empty?
      response
    end

    def self.collect_charts_for(username)
      user_charts_from_gratipay(username).each do |chart_hash|
        UserChart.new(chart_hash.merge("username" => username))
      end
    end
  end
end
