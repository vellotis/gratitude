require "spec_helper"

describe Gratitude::Statistics do

  describe "default attributes" do
    it "includes Gratitude::Connection" do
      expect(Gratitude::Statistics).to include(Gratitude::Connection)
    end
  end

  describe "instance methods" do
    before { VCR.insert_cassette "statistics" }
    after { VCR.eject_cassette }
    let(:stats) { Gratitude::Statistics.current }

    describe "json response" do
      it "returns the correct keys in the json hash" do
        expect(stats.send(:response_body).keys)
          .to eq(
            %w(
              average_tip
              average_tippees
              escrow
              last_thursday
              nach
              nactive
              ncc
              ngivers
              noverlap
              nreceivers
              other_people
              pcc
              punc
              statements
              this_thursday
              tip_distribution_json
              tip_n
              total_backed_tips
              transfer_volume
              )
          )
      end
    end

    describe "#average_tip_amount" do
      it "returns a float" do
        expect(stats.average_tip_amount.class).to be(Float)
      end

      it "returns the same value as its alias: #average_tip" do
        expect(stats.average_tip_amount).to eq(stats.average_tip)
      end
    end

    describe "#average_number_of_tippees" do
      it "returns a fixnum" do
        expect(stats.average_number_of_tippees.class).to be(Fixnum)
      end

      it "returns the same value as its alias: #average_tippees" do
        expect(stats.average_number_of_tippees).to eq(stats.average_tippees)
      end
    end

    describe "#amount_in_escrow" do
      it "returns a float" do
        expect(stats.amount_in_escrow.class).to be(Float)
      end

      it "returns the same value as its alias: #escrow" do
        expect(stats.amount_in_escrow).to eq(stats.escrow)
      end
    end

    describe "#last_thursday" do
      it "returns a string" do
        expect(stats.last_thursday.class).to be(String)
      end
    end

    describe "#number_of_achs" do
      it "returns a fixnum" do
        expect(stats.number_of_ach_credits.class).to be(Fixnum)
      end

      it "returns the same value as its alias: #nach" do
        expect(stats.number_of_ach_credits).to eq(stats.nach)
      end

      it "returns the same value as its alias: #number_of_achs" do
        expect(stats.number_of_ach_credits).to eq(stats.number_of_achs)
      end
    end

    describe "#number_of_active_users" do
      it "returns a fixnum" do
        expect(stats.number_of_active_users.class).to be(Fixnum)
      end

      it "returns the same value as its alias: #nactive" do
        expect(stats.number_of_active_users).to eq(stats.nactive)
      end
    end

    describe "#number_of_credit_cards" do
      it "returns a fixnum" do
        expect(stats.number_of_credit_cards.class).to be(Fixnum)
      end

      it "returns the same value as its alias: #ncc" do
        expect(stats.number_of_credit_cards).to eq(stats.ncc)
      end
    end

    describe "#number_of_givers" do
      it "returns a fixnum" do
        expect(stats.number_of_givers.class).to be(Fixnum)
      end

      it "returns the same value as its alias: #ngivers" do
        expect(stats.number_of_givers).to eq(stats.ngivers)
      end
    end

    describe "#number_who_give_and_receive" do
      it "returns a fixnum" do
        expect(stats.number_who_give_and_receive.class).to be(Fixnum)
      end

      it "returns the same value as its alias: #noverlap" do
        expect(stats.number_who_give_and_receive).to eq(stats.noverlap)
      end
    end

    describe "#number_of_receivers" do
      it "returns a fixnum" do
        expect(stats.number_of_receivers.class).to be(Fixnum)
      end

      it "returns the same value as its alias: #nreceivers" do
        expect(stats.number_of_receivers).to eq(stats.nreceivers)
      end
    end

    describe "#other_people" do
      it "returns a string" do
        expect(stats.other_people.class).to be(String)
      end
    end

    describe "#percentage_of_users_with_credit_cards" do
      it "returns a string" do
        expect(stats.percentage_of_users_with_credit_cards.class).to be(String)
      end

      it "returns the same value as its alias: #pcc" do
        expect(stats.percentage_of_users_with_credit_cards).to eq(stats.pcc)
      end
    end

    describe "#punctuation" do
      it "returns a string" do
        expect(stats.punctuation.class).to be(String)
      end

      it "returns the same value as its alias: #pcc" do
        expect(stats.punctuation).to eq(stats.punc)
      end
    end

    describe "#statements" do
      it "returns an array" do
        expect(stats.statements.class).to be(Array)
      end

      it "contain the currect number of elements in the array" do
        expect(stats.statements.size).to eq(16)
      end

      it "has a hash for each element in the array" do
        expect(stats.statements.first.class).to be(Hash)
      end

      it "has statement as a key in each hash element" do
        stats.statements.each do |statement|
          expect(statement.key?("statement")).to be(true)
        end
      end

      it "has username as a key in each hash element" do
        stats.statements.each do  |statement|
          expect(statement.key?("username")).to be(true)
        end
      end
    end

    describe "#this_thursday" do
      it "returns a string" do
        expect(stats.this_thursday.class).to be(String)
      end
    end

    describe "#tip_distribution_json" do
      it "returns a hash" do
        expect(stats.tip_distribution_json.class).to be(Hash)
      end
    end

    describe "#number_of_tips" do
      it "returns a fixnum" do
        expect(stats.number_of_tips.class).to be(Fixnum)
      end

      it "returns the same value as its alias: #tip_n" do
        expect(stats.number_of_tips).to eq(stats.tip_n)
      end
    end

    describe "#value_of_total_backed_tips" do
      it "returns a float" do
        expect(stats.value_of_total_backed_tips.class).to be(Float)
      end

      it "returns the same value as its alias: #total_backed_tips" do
        expect(stats.value_of_total_backed_tips).to eq(stats.total_backed_tips)
      end
    end

    describe "#transfer_volume" do
      it "returns a float" do
        expect(stats.transfer_volume.class).to be(Float)
      end
    end
  end

end
