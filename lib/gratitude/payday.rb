module Gratitude
  class Payday
    include HTTParty
    base_uri "https://www.gittip.com/about/paydays.json"
    PAYDAYS = []

    attr_reader :ach_fees_volume, :ach_volume, :charge_fees_volume,
                :charge_volume, :number_of_ach_credits, :number_of_active_users,
                :number_of_failing_credit_cards, :number_of_missing_credit_cards,
                :number_of_charges, :number_of_participants, :number_of_tippers,
                :number_of_transfers, :transfer_volume, :transfer_end_time,
                :transfer_start_time

    # Provide aliases so all methods can correspond to the original Gittip API names.
    alias :nachs :number_of_ach_credits
    alias :number_of_achs :number_of_ach_credits
    alias :nactive :number_of_active_users
    alias :number_active :number_of_active_users
    alias :ncc_failing :number_of_failing_credit_cards
    alias :ncc_missing :number_of_missing_credit_cards
    alias :ncharges :number_of_charges
    alias :nparticipants :number_of_participants
    alias :ntippers :number_of_tippers
    alias :ntransfers :number_of_transfers
    alias :ts_end :transfer_end_time
    alias :ts_start :transfer_start_time

    def initialize(options = {})
      @ach_fees_volume = options["ach_fees_volume"]
      @ach_volume = options["ach_volume"]
      @charge_fees_volume = options["charge_fees_volume"]
      @charge_volume = options["charge_volume"]
      @number_of_ach_credits = options["nachs"]
      @number_of_active_users = options["nactive"]
      @number_of_failing_credit_cards = options["ncc_failing"]
      @number_of_missing_credit_cards = options["ncc_missing"]
      @number_of_charges = options["ncharges"]
      @number_of_participants = options["nparticipants"]
      @number_of_tippers = options["ntippers"]
      @number_of_transfers = options["ntransfers"]
      @transfer_volume = options["transfer_volume"]
      @transfer_end_time = DateTime.parse(options["ts_end"])
      @transfer_start_time = DateTime.parse(options["ts_start"])
      PAYDAYS << self
    end

    # Class Methods
    def self.all
      collect_paydays if PAYDAYS.empty?
      PAYDAYS
    end

    def self.most_recent
      sort_by_ts_end.first
    end

    def self.sort_by_ts_end
      all.sort_by { |p| p.ts_end }.reverse
    end

    def self.get_paydays_from_gittip
      get(base_uri).to_a
    end

    def self.collect_paydays
      get_paydays_from_gittip.each do |payday_hash|
        Payday.new(payday_hash)
      end
    end

  end # Payday
end # Gratitude