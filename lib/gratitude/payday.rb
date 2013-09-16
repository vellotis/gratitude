module Gratitude
  class Payday
    include HTTParty
    base_uri "https://www.gittip.com/about/paydays.json"
    PAYDAYS = []

    attr_reader :ach_fees_volume, :ach_volume, :charge_fees_volume, 
                :charge_volume, :number_of_achs, :number_active,
                :number_of_failing_credit_cards, :number_of_missing_credit_cards,
                :number_of_charges, :number_of_participants, :number_of_tippers,
                :number_of_transfers, :transfer_volume, :ts_end, :ts_start



    # Class Methods
    def self.get_paydays_from_gittip
      get(base_uri).to_a
    end


    # Instance Methods

  end # Payday
end # Gratitude