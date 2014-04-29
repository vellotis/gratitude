module Gratitude
  class Chart
    extend Connection
    CHARTS = []

    attr_reader :active_users, :charges, :date, :total_gifts, :total_users,
                :weekly_gifts, :withdrawals

    def initialize(options = {})
      @active_users = options["active_users"]
      @charges = options["charges"]
      @date = Date.parse(options["date"]) if options["date"]
      @total_gifts = options["total_gifts"]
      @total_users = options["total_users"]
      @weekly_gifts = options["weekly_gifts"]
      @withdrawals = options["withdrawals"]
      CHARTS << self
    end

    def self.all
      collect_charts if CHARTS.empty?
      CHARTS
    end

    def self.newest
      sort_by_date.first
    end

    def self.oldest
      sort_by_date.last
    end

    def self.sort_by_date
      all.sort_by { |chart| chart.date }.reverse
    end

    def self.charts_from_gittip
      faraday.get("/about/charts.json").body.to_a
    end

    def self.collect_charts
      charts_from_gittip.each do |chart_hash|
        Chart.new(chart_hash)
      end
    end
  end
end
