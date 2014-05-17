# encoding: utf-8

module Gratitude
  class Statistics
    include Connection

    class << self
      alias_method :current, :new
    end

    def average_tip_amount
      response_body["average_tip"]
    end
    alias_method :average_tip, :average_tip_amount

    def average_number_of_tippees
      response_body["average_tippees"]
    end
    alias_method :average_tippees, :average_number_of_tippees

    def amount_in_escrow
      response_body["escrow"]
    end
    alias_method :escrow, :amount_in_escrow

    def last_thursday
      response_body["last_thursday"]
    end

    def number_of_ach_credits
      response_body["nach"].to_i
    end
    alias_method :nach, :number_of_ach_credits
    alias_method :number_of_achs, :number_of_ach_credits

    def number_of_active_users
      response_body["nactive"]
    end
    alias_method :nactive, :number_of_active_users

    def number_of_credit_cards
      response_body["ncc"]
    end
    alias_method :ncc, :number_of_credit_cards

    def number_of_givers
      response_body["ngivers"]
    end
    alias_method :ngivers, :number_of_givers

    def number_who_give_and_receive
      response_body["noverlap"]
    end
    alias_method :noverlap, :number_who_give_and_receive

    def number_of_receivers
      response_body["nreceivers"]
    end
    alias_method :nreceivers, :number_of_receivers

    def other_people
      response_body["other_people"]
    end

    def percentage_of_users_with_credit_cards
      response_body["pcc"].strip
    end
    alias_method :pcc, :percentage_of_users_with_credit_cards

    def punctuation
      response_body["punc"]
    end
    alias_method :punc, :punctuation

    def statements
      response_body["statements"]
    end

    def this_thursday
      response_body["this_thursday"]
    end

    def tip_distribution_json
      response_body["tip_distribution_json"]
    end

    def number_of_tips
      response_body["tip_n"]
    end
    alias_method :tip_n, :number_of_tips

    def value_of_total_backed_tips
      response_body["total_backed_tips"]
    end
    alias_method :total_backed_tips, :value_of_total_backed_tips

    def transfer_volume
      response_body["transfer_volume"]
    end

    private

    def response
      @response ||= faraday.get("/about/stats.json")
    end

    def response_body
      @response_body ||= response.body
    end
  end # Statistics
end # Gratitude
