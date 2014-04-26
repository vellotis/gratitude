require "spec_helper"

describe Gratitude::UserChart do
  before { VCR.insert_cassette "user_charts" }
  after { VCR.eject_cassette }

  describe "default attributes" do
    it "extends Gratitude::Connection" do
      expect(Gratitude::UserChart.is_a?(Gratitude::Connection)).to eq(true)
    end

    it "initially sets the UserChartS constant to an empty array" do
      expect(Gratitude::UserChart::USER_CHARTS).to eq([])
    end
  end

  describe "class methods" do
    before(:each) { Gratitude::UserChart::USER_CHARTS = [] }
    describe "#all_for_user" do
      it "returns an array" do
        expect(Gratitude::UserChart.all_for_user("Gittip").class)
          .to be(Array)
      end

      context "when the requested Gittip user exists" do
        it "updates the USER_CHARTS constant when it is empty" do
          expect { Gratitude::UserChart.all_for_user("Gittip") }
            .to change { Gratitude::UserChart::USER_CHARTS.size }.from(0)
        end

        it "its array should be comprised of User_Chart objects" do
          Gratitude::UserChart.all_for_user("Gittip").each do |user_chart|
            expect(user_chart.class).to eq(Gratitude::UserChart)
          end
        end

        it "only includes charts for a given username" do
          Gratitude::UserChart.all_for_user("whit537")
          Gratitude::UserChart.all_for_user("Gittip").each do |user_chart|
            expect(user_chart.username).to eq("Gittip")
          end
        end
      end

      context "when the requested Gittip user does not exist" do
        before { VCR.insert_cassette "user_not_found" }
        after { VCR.eject_cassette }

        it "raises a UsernameNotFoundError" do
          expect { Gratitude::UserChart.all_for_user("non_existing_user") }
            .to raise_error(Gratitude::UsernameNotFoundError)
        end
      end
    end


    describe "#sort_by_date_for_user" do
      it "places the newest user chart before the oldest user chart" do
        expect(Gratitude::UserChart.sort_by_date_for_user("Gittip").first.date)
          .to be > (Gratitude::UserChart.sort_by_date_for_user("Gittip").last.date)
      end
    end

    describe "#newest_for" do
      it "returns the most recent payday" do
        expect(Gratitude::UserChart.newest_for("Gittip"))
          .to eq(Gratitude::UserChart.sort_by_date_for_user("Gittip").first)
      end
    end

    describe "#oldest" do
      it "returns the oldest payday" do
        expect(Gratitude::UserChart.oldest_for("Gittip"))
          .to eq(Gratitude::UserChart.sort_by_date_for_user("Gittip").last)
      end
    end
  end
  describe "initialization and instance methods" do

    it "adds the initialized object to the CHARTS constant" do
      expect { Gratitude::UserChart.new() }
        .to change{ Gratitude::UserChart::USER_CHARTS.size }.by(1)
    end

    let(:user_chart) do
      Gratitude::UserChart.new(
        {
          "username" => "Gittip",
          "date" => "2014-03-27",
          "npatrons" => 137,
          "receipts" => 416.94
        }
      )
    end

    describe "#username" do
      it "sets the correct username" do
        expect(user_chart.username).to eq("Gittip")
      end
    end

    describe "#date" do
      it "returns a Date object" do
        expect(user_chart.date.class).to eq(Date)
      end

      it "has the correct year" do
        expect(user_chart.date.year).to eq(2014)
      end

      it "has the correct month" do
        expect(user_chart.date.month).to eq(3)
      end

      it "has the correct date" do
        expect(user_chart.date.day).to eq(27)
      end
    end

    describe "#number_of_patrons" do
      it "returns the correct number of patrons" do
        expect(user_chart.number_of_patrons).to eq(137)
      end

      it "returns the same value as its alias: npatrons" do
        expect(user_chart.number_of_patrons).to eq(user_chart.npatrons)
      end
    end

    describe "#receipts" do
      it "returns the correct number of patrons" do
        expect(user_chart.receipts).to eq(416.94)
      end
    end
  end

end
