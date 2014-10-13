# encoding: utf-8

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
      all.sort_by(&:date).reverse
    end
    private_class_method :sort_by_date

    def self.charts_from_gratipay
      faraday.get("/about/charts.json").body.to_a
    end
    private_class_method :charts_from_gratipay

    def self.collect_charts
      charts_from_gratipay.each { |chart_hash| Chart.new(chart_hash) }
    end
    private_class_method :collect_charts
  end
end
