require "spec_helper"

describe Gratitude::Payday do

  describe "default attributes" do
    it "extends Gratitude::Connection" do
      expect(Gratitude::Payday.is_a?(Gratitude::Connection)).to eq(true)
    end

    it "initially sets the PAYDAYS constant to an empty array" do
      expect(Gratitude::Payday::PAYDAYS).to eq([])
    end
  end

  describe "class methods" do
    before { VCR.insert_cassette "paydays" }
    after { VCR.eject_cassette }

    describe "#get_paydays_from_gittip" do
      it "returns an array" do
        expect(Gratitude::Payday.get_paydays_from_gittip.class).to be(Array)
      end

      it "returns the correct number of items in the array" do
        expect(Gratitude::Payday.get_paydays_from_gittip.size).to eq(68)
      end
    end

    describe "#collect_paydays" do
      it "creates all payday objects and stores them in the PAYDAYS constant" do
        expect {
          Gratitude::Payday.collect_paydays
        }.to change { Gratitude::Payday::PAYDAYS.size }.from(0).to(68)
      end
    end

    describe "#all" do
      before { Gratitude::Payday::PAYDAYS = [] }

      it "returns an array" do
        expect(Gratitude::Payday.all.class).to be(Array)
      end

      it "updates the PAYDAYS constant when it is empty" do
        expect(Gratitude::Payday.all.size).to eq(68)
      end

      it "its array should be comprised of Payday objects" do
        expect(Gratitude::Payday.all.first.class).to be(Gratitude::Payday)
      end
    end

    describe "#sort_by_ts_end" do
      it "places the newest payday first" do
        expect(Gratitude::Payday.sort_by_ts_end.first.ts_end.year).to eq(2013)
        expect(Gratitude::Payday.sort_by_ts_end.first.ts_end.month).to eq(9)
        expect(Gratitude::Payday.sort_by_ts_end.first.ts_end.day).to eq(12)
      end

      it "places the oldest item last" do
        expect(Gratitude::Payday.sort_by_ts_end.last.ts_end.year).to eq(2012)
        expect(Gratitude::Payday.sort_by_ts_end.last.ts_end.month).to eq(6)
        expect(Gratitude::Payday.sort_by_ts_end.last.ts_end.day).to eq(1)
      end
    end

    describe "#most_recent" do
      it "returns the most recent payday" do
        expect(Gratitude::Payday.most_recent.ts_end.year).to eq(2013)
        expect(Gratitude::Payday.most_recent.ts_end.month).to eq(9)
        expect(Gratitude::Payday.most_recent.ts_end.day).to eq(12)
      end
    end

  end # class methods

  describe "initialization and instance methods" do

    it "adds the initialized object to the PAYDAYS constant" do
      expect { Gratitude::Payday.new( {
        'ts_end' => "2013-09-12T14:01:41.848587+00:00",
        'ts_start' => "2013-09-12T12:36:52.967371+00:00"
        } )
      }.to change{ Gratitude::Payday::PAYDAYS.size }.by(1)
    end

    let(:payday) { Gratitude::Payday.new( {
        'ach_fees_volume' => 0,
        'ach_volume' => -2246.96,
        'charge_fees_volume' => 216.09,
        'charge_volume' => 4583.22,
        'nachs' => 53,
        'nactive' => 1719,
        'ncc_failing' => 178,
        'ncc_missing' => 1222,
        'ncharges' => 276,
        'nparticipants' => 19567,
        'ntippers' => 1105,
        'ntransfers' => 3309,
        'transfer_volume' => 5464.38,
        'ts_end' => "2013-09-12T14:01:41.848587+00:00",
        'ts_start' => "2013-09-12T12:36:52.967371+00:00"
      } )
    }

    describe "#ach_fees_volume" do
      it "returns the correct ach fees volume" do
        expect(payday.ach_fees_volume).to eq(0)
      end
    end

    describe "#ach_volume" do
      it "returns the correct ach volume" do
        expect(payday.ach_volume).to eq(-2246.96)
      end
    end

    describe "#charge_fees_volume" do
      it "returns the correct charge fees volume" do
        expect(payday.charge_fees_volume).to eq(216.09)
      end
    end

    describe "#charge_volume" do
      it "returns the correct charge volume" do
        expect(payday.charge_volume).to eq(4583.22)
      end
    end

    describe "#number_of_ach_credits" do
      it "returns the correct number of achs" do
        expect(payday.number_of_ach_credits).to eq(53)
      end

      it "returns the same value as #nachs" do
        expect(payday.number_of_ach_credits).to eq(payday.nachs)
      end

      it "returns the same value as #number_of_achs" do
        expect(payday.number_of_ach_credits).to eq(payday.number_of_achs)
      end
    end

    describe "#number_of_active_users" do
      it "returns the correct number active" do
        expect(payday.number_of_active_users).to eq(1719)
      end

      it "returns the same value as #nactive" do
        expect(payday.number_of_active_users).to eq(payday.nactive)
      end

      it "returns the same value as #number_active" do
        expect(payday.number_of_active_users).to eq(payday.number_active)
      end
    end

    describe "#number_of_failing_credit_cards" do
      it "returns the correct number of failing credit cards" do
        expect(payday.number_of_failing_credit_cards).to eq(178)
      end

      it "returns the same value as #ncc_failing" do
        expect(payday.number_of_failing_credit_cards).to eq(payday.ncc_failing)
      end
    end

    describe "#number_of_missing_credit_cards" do
      it "returns the correct number of missing credit cards" do
        expect(payday.number_of_missing_credit_cards).to eq(1222)
      end

      it "returns the same value as #ncc_missing" do
        expect(payday.number_of_missing_credit_cards).to eq(payday.ncc_missing)
      end
    end

    describe "#number_of_charges" do
      it "returns the correct number of charges" do
        expect(payday.number_of_charges).to eq(276)
      end

      it "returns the same value as #ncharges" do
        expect(payday.number_of_charges).to eq(payday.ncharges)
      end
    end

    describe "#number_of_participants" do
      it "returns the correct number of participants" do
        expect(payday.number_of_participants).to eq(19567)
      end

      it "returns the same value as #nparticipants" do
        expect(payday.number_of_participants).to eq(payday.nparticipants)
      end
    end

    describe "#number_of_tippers" do
      it "returns the correct number of tippers" do
        expect(payday.number_of_tippers).to eq(1105)
      end

      it "returns the same value as #ntippers" do
        expect(payday.number_of_tippers).to eq(payday.ntippers)
      end
    end

    describe "#number_of_transfers" do
      it "returns the correct number of transfers" do
        expect(payday.number_of_transfers).to eq(3309)
      end

      it "returns the same value as #ntransfers" do
        expect(payday.number_of_transfers).to eq(payday.ntransfers)
      end
    end

    describe "#transfer_volume" do
      it "responsd to #transfer_volume" do
        expect(payday.transfer_volume).to eq(5464.38)
      end
    end

    describe "#transfer_end_time" do
      it "returns a DateTime object" do
        expect(payday.transfer_end_time.class).to eq(DateTime)
      end

      it "has the correct year" do
        expect(payday.transfer_end_time.year).to eq(2013)
      end

      it "has the correct month" do
        expect(payday.transfer_end_time.month).to eq(9)
      end

      it "has the correct date" do
        expect(payday.transfer_end_time.day).to eq(12)
      end

      it "returns the same value as #ts_end" do
        expect(payday.transfer_end_time).to eq(payday.ts_end)
      end
    end

    describe "#transfer_start_time" do
      it "returns a DateTime object" do
        expect(payday.transfer_start_time.class).to eq(DateTime)
      end

      it "has the correct year" do
        expect(payday.transfer_start_time.year).to eq(2013)
      end

      it "has the correct month" do
        expect(payday.transfer_start_time.month).to eq(9)
      end

      it "has the correct date" do
        expect(payday.transfer_start_time.day).to eq(12)
      end

      it "returns the same value as #ts_start" do
        expect(payday.transfer_start_time).to eq(payday.ts_start)
      end
    end

  end # initialization and instance methods

end
