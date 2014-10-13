# encoding: utf-8

module Gratitude
  class Statistics
    include Connection

    class << self
      alias_method :current, :new
    end

    def nach
      Integer(response_body.fetch("nach"))
    end
    alias_method :number_of_ach_credits, :nach
    alias_method :number_of_achs, :nach

    def pcc
      response_body.fetch("pcc").strip
    end
    alias_method :percentage_of_users_with_credit_cards, :pcc

    %w(
      average_tip
      average_tippees
      escrow
      last_thursday
      nactive
      ncc
      ngivers
      noverlap
      nreceivers
      other_people
      punc
      statements
      this_thursday
      tip_distribution
      tip_n
      total_backed_tips
      transfer_volume
    ).each do |response_key|
      define_method(response_key) { response_body.fetch(response_key) }
    end

    alias_method :average_tip_amount, :average_tip
    alias_method :average_number_of_tippees, :average_tippees
    alias_method :amount_in_escrow, :escrow
    alias_method :number_of_active_users, :nactive
    alias_method :number_of_credit_cards, :ncc
    alias_method :number_of_givers, :ngivers
    alias_method :number_who_give_and_receive, :noverlap
    alias_method :number_of_receivers, :nreceivers
    alias_method :punctuation, :punc
    alias_method :tip_distribution_json, :tip_distribution
    alias_method :number_of_tips, :tip_n
    alias_method :value_of_total_backed_tips, :total_backed_tips

    private

    def response
      @response ||= faraday.get("/about/stats.json")
    end

    def response_body
      @response_body ||= response.body
    end
  end # Statistics
end # Gratitude
