# encoding: utf-8

require "spec_helper"

describe Gratitude::Chart do
  before { VCR.insert_cassette "charts" }
  after { VCR.eject_cassette }

  describe "default attributes" do
    it "extends Gratitude::Connection" do
      expect(Gratitude::Chart.is_a?(Gratitude::Connection)).to eq(true)
    end

    it "initially sets the CHARTS constant to an empty array" do
      expect(Gratitude::Chart::CHARTS).to eq([])
    end
  end

  describe "class methods" do
    describe "#all" do
      before { Gratitude::Chart::CHARTS = [] }

      it "returns an array" do
        expect(Gratitude::Chart.all.class).to be(Array)
      end

      it "updates the CHARTS constant when it is empty" do
        expect { Gratitude::Chart.all }
          .to change { Gratitude::Chart::CHARTS.size }.from(0)
      end

      it "its array should be comprised of Chart objects" do
        Gratitude::Chart.all.each do |chart|
          expect(chart.class).to eq(Gratitude::Chart)
        end
      end
    end

    describe "#sort_by_date" do
      it "places the newest chart before the oldest chart" do
        expect(Gratitude::Chart.sort_by_date.first.date)
          .to be > (Gratitude::Chart.sort_by_date.last.date)
      end
    end

    describe "#newest" do
      it "returns the most recent payday" do
        expect(Gratitude::Chart.newest)
          .to eq(Gratitude::Chart.sort_by_date.first)
      end
    end

    describe "#oldest" do
      it "returns the oldest chart" do
        expect(Gratitude::Chart.oldest)
          .to eq(Gratitude::Chart.sort_by_date.last)
      end
    end
  end

  describe "initialization and instance methods" do

    it "adds the initialized object to the CHARTS constant" do
      expect { Gratitude::Chart.new }
        .to change { Gratitude::Chart::CHARTS.size }.by(1)
    end

    let(:chart) do
      Gratitude::Chart.new(
        "active_users" => 25,
        "charges" => 25.28,
        "date" => "2012-06-08",
        "total_gifts" => 27.76,
        "total_users" => 175,
        "weekly_gifts" => 24.80,
        "withdrawals" => 0.00
      )
    end

    describe "#active_users" do
      it "returns the correct number of active users" do
        expect(chart.active_users).to eq(25)
      end
    end

    describe "#charges" do
      it "returns the correct number of charges" do
        expect(chart.charges).to eq(25.28)
      end
    end

    describe "#date" do
      it "returns a Date object" do
        expect(chart.date.class).to eq(Date)
      end

      it "has the correct year" do
        expect(chart.date.year).to eq(2012)
      end

      it "has the correct month" do
        expect(chart.date.month).to eq(6)
      end

      it "has the correct date" do
        expect(chart.date.day).to eq(8)
      end
    end

    describe "#total_gifts" do
      it "returns the correct number of total gifts" do
        expect(chart.total_gifts).to eq(27.76)
      end
    end

    describe "#total_users" do
      it "returns the correct number of total users" do
        expect(chart.total_users).to eq(175)
      end
    end

    describe "#weekly_gifts" do
      it "returns the correct number of weekly gifts" do
        expect(chart.weekly_gifts).to eq(24.80)
      end
    end

    describe "#withdrawals" do
      it "returns the correct number of withdrawals" do
        expect(chart.withdrawals).to eq(0)
      end
    end
  end

end
