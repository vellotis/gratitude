module Gratitude
  class Statistics
    include HTTParty
    base_uri "https://www.gittip.com/about/stats.json"

    attr_reader :response

    def initialize
      @response = self.class.get("")
    end

    def average_tip_amount
      response["average_tip"]
    end
    alias :average_tip :average_tip_amount

    def average_number_of_tippees
      response["average_tippees"]
    end
    alias :average_tippees :average_number_of_tippees

    def amount_in_escrow
      response["escrow"]
    end
    alias :escrow :amount_in_escrow

    def last_thursday
      response["last_thursday"]
    end

    def number_of_ach_credits
      response["nach"].to_i
    end
    alias :nach :number_of_ach_credits
    alias :number_of_achs :number_of_ach_credits

    def number_of_active_users
      response["nactive"]
    end
    alias :nactive :number_of_active_users

    def number_of_credit_cards
      response["ncc"]
    end
    alias :ncc :number_of_credit_cards

    def number_of_givers
      response["ngivers"]
    end
    alias :ngivers :number_of_givers

    def number_who_give_and_receive
      response["noverlap"]
    end
    alias :noverlap :number_who_give_and_receive

    def number_of_receivers
      response["nreceivers"]
    end
    alias :nreceivers :number_of_receivers

    def other_people
      response["other_people"]
    end

    def percentage_of_users_with_credit_cards
      response["pcc"].strip
    end
    alias :pcc :percentage_of_users_with_credit_cards

    def punctuation
      response["punc"]
    end
    alias :punc :punctuation

    def statements
      response["statements"]
    end

    def this_thursday
      response["this_thursday"]
    end

    def tip_distribution_json
      response["tip_distribution_json"]
    end

    def number_of_tips
      response["tip_n"]
    end
    alias :tip_n :number_of_tips

    def value_of_total_backed_tips
      response["total_backed_tips"]
    end
    alias :total_backed_tips :value_of_total_backed_tips

    def transfer_volume
      response["transfer_volume"]
    end

  end # Statistics
end # Gratitude