require "spec_helper"

describe Gratitude::Payday do
  
  describe "default attributes" do

    it "should include httparty methods" do
      Gratitude::Payday.should include(HTTParty)
    end

    it "should have the base uri set to gittip's payday api endpoint" do
      expect(Gratitude::Payday.base_uri).to eq("https://www.gittip.com/about/paydays.json")
    end

    it "should have the PAYDAYS constant initially set to an empty array" do
      expect(Gratitude::Payday::PAYDAYS).to eq([])
    end

  end # default attributes

  describe "class methods" do
    
    before do
      VCR.insert_cassette "paydays"
    end

    after do
      VCR.eject_cassette
    end

    describe "#get_paydays_from_gittip" do
      it "returns an array" do
        expect(Gratitude::Payday.get_paydays_from_gittip.class).to eq(Array)
      end

      it "returns the correct number of items in the array" do
        expect(Gratitude::Payday.get_paydays_from_gittip.size).to eq(68)
      end
    end


  end # class methods

  describe "instance methods" do
    let(:payday) { Gratitude::Payday.new }

    it "should respond to #ach_fees_volume" do
      expect(payday).to respond_to(:ach_fees_volume)
    end

    it "should respond to #ach_volume" do
      expect(payday).to respond_to(:ach_volume)
    end

    it "should respond to #charge_fees_volume" do
      expect(payday).to respond_to(:charge_fees_volume)
    end

    it "should respond to #charge_volume" do
      expect(payday).to respond_to(:charge_volume)
    end

    it "should respond to #number_of_achs" do
      expect(payday).to respond_to(:number_of_achs)
    end

    it "should respond to #number_active" do
      expect(payday).to respond_to(:number_active)
    end

    it "should respond to #number_of_failing_credit_cards" do
      expect(payday).to respond_to(:number_of_failing_credit_cards)
    end

    it "should respond to #number_of_missing_credit_cards" do
      expect(payday).to respond_to(:number_of_missing_credit_cards)
    end

    it "should respond to #number_of_charges" do
      expect(payday).to respond_to(:number_of_charges)
    end

    it "should respond to #number_of_participants" do
      expect(payday).to respond_to(:number_of_participants)
    end

    it "should respond to #number_of_tippers" do
      expect(payday).to respond_to(:number_of_tippers)
    end

    it "should respond to #number_of_transfers" do
      expect(payday).to respond_to(:number_of_transfers)
    end

    it "should respond to #transfer_volume" do
      expect(payday).to respond_to(:transfer_volume)
    end

    it "should respond to #transfer_volume" do
      expect(payday).to respond_to(:transfer_volume)
    end

    it "should respond to #ts_end" do
      expect(payday).to respond_to(:ts_end)
    end

    it "should respond to #ts_start" do
      expect(payday).to respond_to(:ts_start)
    end

  end # instance methods

end