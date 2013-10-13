require "spec_helper"

describe Gratitude::Statistics do

  describe "default attributes" do
    it "should include httparty methods" do
      Gratitude::Statistics.should include(HTTParty)
    end


    it "should have the base uri set to gittip's payday api endpoint" do
      expect(Gratitude::Statistics.base_uri).to eq("https://www.gittip.com/about/stats.json")
    end
  end # default attributes

  describe "instance methods" do

    before do
      VCR.insert_cassette "statistics"
    end

    after do
      VCR.eject_cassette
    end

    let(:stats) { Gratitude::Statistics.current }

    it "should respond to #repsonse" do
      expect(stats).to respond_to(:response)
    end

    describe "#average_tip_amount" do
      it "should return the correct average tip amount" do
        expect(stats.average_tip_amount).to eq(1.2348237280979524)
      end

      it "should return a float" do
        expect(stats.average_tip_amount.class).to be(Float)
      end

      it "should return the same value as its alias: #average_tip" do
        expect(stats.average_tip_amount).to eq(stats.average_tip)
      end
    end

    describe "#average_number_of_tippees" do
      it "should return the correct average number of tippees" do
        expect(stats.average_number_of_tippees).to eq(3)
      end

      it "should return a fixnum" do
        expect(stats.average_number_of_tippees.class).to be(Fixnum)
      end

      it "should return the same value as its alias: #average_tippees" do
        expect(stats.average_number_of_tippees).to eq(stats.average_tippees)
      end
    end

    describe "#amount_in_escrow" do
      it "should return the correct amount in escrow" do
        expect(stats.amount_in_escrow).to eq(50441.17)
      end

      it "should return a float" do
        expect(stats.amount_in_escrow.class).to be(Float)
      end

      it "should return the same value as its alias: #escrow" do
        expect(stats.amount_in_escrow).to eq(stats.escrow)
      end
    end

    describe "#last_thursday" do
      it "should return the correct value for last thursday" do
        expect(stats.last_thursday).to eq("last Thursday")
      end

      it "should be a string" do
        expect(stats.last_thursday.class).to be(String)
      end
    end

    describe "#number_of_achs" do
      it "should return the correct number of ach credits" do
        expect(stats.number_of_ach_credits).to eq(299)
      end

      it "should be a fixnum" do
        expect(stats.number_of_ach_credits.class).to be(Fixnum)
      end

      it "should return the same value as its alias: #nach" do
        expect(stats.number_of_ach_credits).to eq(stats.nach)
      end

      it "should return the same value as its alias: #number_of_achs" do
        expect(stats.number_of_ach_credits).to eq(stats.number_of_achs)
      end
    end

    describe "#number_of_active_users" do
      it "should return the correct number of active users" do
        expect(stats.number_of_active_users).to eq(1719)
      end

      it "should be a fixnum" do
        expect(stats.number_of_active_users.class).to be(Fixnum)
      end

      it "should return the same value as its alias: #nactive" do
        expect(stats.number_of_active_users).to eq(stats.nactive)
      end
    end

    describe "#number_of_credit_cards" do
      it "should return the correct number of credit cards on file" do
        expect(stats.number_of_credit_cards).to eq(1496)
      end

      it "should be a fixnum" do
        expect(stats.number_of_credit_cards.class).to be(Fixnum)
      end

      it "should return the same value as its alias: #ncc" do
        expect(stats.number_of_credit_cards).to eq(stats.ncc)
      end
    end

    describe "#number_of_givers" do
      it "should return the correct number of givers" do
        expect(stats.number_of_givers).to eq(1113)
      end

      it "should be a fixnum" do
        expect(stats.number_of_givers.class).to be(Fixnum)
      end

      it "should return the same value as its alias: #ngivers" do
        expect(stats.number_of_givers).to eq(stats.ngivers)
      end
    end

    describe "#number_who_give_and_receive" do
      it "should return the correct number of users who both give and receive" do
        expect(stats.number_who_give_and_receive).to eq(301)
      end

      it "should be a fixnum" do
        expect(stats.number_who_give_and_receive.class).to be(Fixnum)
      end

      it "should return the same value as its alias: #noverlap" do
        expect(stats.number_who_give_and_receive).to eq(stats.noverlap)
      end
    end

    describe "#number_of_receivers" do
      it "should return the correct number of receivers" do
        expect(stats.number_of_receivers).to eq(907)
      end

      it "should be a fixnum" do
        expect(stats.number_of_receivers.class).to be(Fixnum)
      end

      it "should return the same value as its alias: #nreceivers" do
        expect(stats.number_of_receivers).to eq(stats.nreceivers)
      end
    end

    describe "#other_people" do
      it "should return the correct value for #other_people" do
        expect(stats.other_people).to eq("three other people")
      end

      it "should be a string" do
        expect(stats.other_people.class).to be(String)
      end
    end

    describe "#percentage_of_users_with_credit_cards" do
      it "should return the correct value for #percentage_of_users_with_credit_cards" do
        expect(stats.percentage_of_users_with_credit_cards).to eq("7.6")
      end

      it "should be a string" do
        expect(stats.percentage_of_users_with_credit_cards.class).to be(String)
      end

      it "should return the same value as its alias: #pcc" do
        expect(stats.percentage_of_users_with_credit_cards).to eq(stats.pcc)
      end
    end

    describe "#punctuation" do
      it "should return the correct value for #punctuation" do
        expect(stats.punctuation).to eq(".")
      end

      it "should be a string" do
        expect(stats.punctuation.class).to be(String)
      end

      it "should return the same value as its alias: #pcc" do
        expect(stats.punctuation).to eq(stats.punc)
      end
    end

    describe "#statements" do
      it "should return an array" do
        expect(stats.statements.class).to be(Array)
      end

      it "should contain 16 elements in the array" do
        expect(stats.statements.size).to eq(16)
      end

      it "should have a hash for each element in the array" do
        expect(stats.statements.first.class).to be(Hash)
      end

      it "should have statement as a key in each hash element" do
        expect(stats.statements.first.has_key?("statement")).to be(true)
      end

      it "should have username as a key in each hash element" do
        expect(stats.statements.first.has_key?("username")).to be(true)
      end
    end

    describe "#this_thursday" do
      it "should return the correct value for this thursday" do
        expect(stats.this_thursday).to eq("this Thursday")
      end

      it "should be a string" do
        expect(stats.this_thursday.class).to be(String)
      end
    end

    describe "#tip_distribution_json" do
      it "should return a hash" do
        expect(stats.tip_distribution_json.class).to be(Hash)
      end
    end

    describe "#number_of_tips" do
      it "should return the correct number of tips" do
        expect(stats.number_of_tips).to eq(4710)
      end

      it "should be a fixnum" do
        expect(stats.number_of_tips.class).to be(Fixnum)
      end

      it "should return the same value as its alias: #tip_n" do
        expect(stats.number_of_tips).to eq(stats.tip_n)
      end
    end

    describe "#value_of_total_backed_tips" do
      it "should return the correct value of total backed tips" do
        expect(stats.value_of_total_backed_tips).to eq(5849.36)
      end

      it "should be a float" do
        expect(stats.value_of_total_backed_tips.class).to be(Float)
      end

      it "should return the same value as its alias: #total_backed_tips" do
        expect(stats.value_of_total_backed_tips).to eq(stats.total_backed_tips)
      end
    end

    describe "#transfer_volume" do
      it "should return the correct transfer volume" do
        expect(stats.transfer_volume).to eq(5464.38)
      end

      it "should be a float" do
        expect(stats.transfer_volume.class).to be(Float)
      end
    end
  end

end