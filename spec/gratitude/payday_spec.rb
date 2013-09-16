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

  describe "initialization and instance methods" do

    it "should add the initialized object to the PAYDAYS constant" do
      expect { Gratitude::Payday.new( {
        ts_end: "2013-09-12T14:01:41.848587+00:00",
        ts_start: "2013-09-12T12:36:52.967371+00:00"
        } )
      }.to change{ Gratitude::Payday::PAYDAYS.size }.from(0).to(1)
    end

    let(:payday) { Gratitude::Payday.new( {
        ach_fees_volume: 0,
        ach_volume: -2246.96,
        charge_fees_volume: 216.09,
        charge_volume: 4583.22,
        nachs: 53,
        nactive: 1719,
        ncc_failing: 178,
        ncc_missing: 1222,
        ncharges: 276,
        nparticipants: 19567,
        ntippers: 1105,
        ntransfers: 3309,
        transfer_volume: 5464.38,
        ts_end: "2013-09-12T14:01:41.848587+00:00",
        ts_start: "2013-09-12T12:36:52.967371+00:00"
      } )
    }

    describe "#ach_fees_volume" do
      it "should return the correct ach fees volume" do
        expect(payday.ach_fees_volume).to eq(0)
      end
    end

    describe "#ach_volume" do
      it "should return the correct ach volume" do
        expect(payday.ach_volume).to eq(-2246.96)
      end
    end

    describe "#charge_fees_volume" do
      it "should return the correct charge fees volume" do
        expect(payday.charge_fees_volume).to eq(216.09)
      end
    end

    describe "#charge_volume" do
      it "should return the correct charge volume" do
        expect(payday.charge_volume).to eq(4583.22)
      end
    end

    describe "#number_of_achs" do
      it "should return the correct number of achs" do
        expect(payday.number_of_achs).to eq(53)
      end
    end

    describe "#number_active" do
      it "should return the correct number active" do
        expect(payday.number_active).to eq(1719)
      end
    end

    describe "#number_of_failing_credit_cards" do
      it "should return the correct number of failing credit cards" do
        expect(payday.number_of_failing_credit_cards).to eq(178)
      end
    end

    describe "#number_of_missing_credit_cards" do
      it "should return the correct number of missing credit cards" do
        expect(payday.number_of_missing_credit_cards).to eq(1222)
      end
    end

    describe "#number_of_charges" do
      it "should return the correct number of charges" do
        expect(payday.number_of_charges).to eq(276)
      end
    end

    describe "#number_of_participants" do
      it "should return the correct number of participants" do
        expect(payday.number_of_participants).to eq(19567)
      end
    end

    describe "#number_of_tippers" do
      it "should respond to #number_of_tippers" do
        expect(payday.number_of_tippers).to eq(1105)
      end
    end

    describe "#number_of_transfers" do
      it "should return the correct number of transfers" do
        expect(payday.number_of_transfers).to eq(3309)
      end
    end

    describe "#transfer_volume" do
      it "should respond to #transfer_volume" do
        expect(payday.transfer_volume).to eq(5464.38)
      end
    end

    describe "#ts_end" do
      it "should return a DateTime object" do
        expect(payday.ts_end.class).to eq(DateTime)
      end

      it "should have the correct year" do
        expect(payday.ts_end.year).to eq(2013)
      end

      it "should have the correct month" do
        expect(payday.ts_end.month).to eq(9)
      end

      it "should have the correct date" do
        expect(payday.ts_end.day).to eq(12)
      end
    end

    describe "#ts_start" do
      it "should return a DateTime object" do
        expect(payday.ts_start.class).to eq(DateTime)
      end

      it "should have the correct year" do
        expect(payday.ts_start.year).to eq(2013)
      end

      it "should have the correct month" do
        expect(payday.ts_start.month).to eq(9)
      end

      it "should have the correct date" do
        expect(payday.ts_start.day).to eq(12)
      end
    end


  end # initialization and instance methods

end