require "spec_helper"

describe Gratitude::Client::Tips do
  let(:username) { "gratitude_test" }
  let(:api_key) { "5962b93a-5bf7-4cb6-ae6f-aa4114c5e4f2" }
  let(:client) do
    Gratitude::Client.new(:username => username, :api_key => api_key)
  end

  describe "GET Requests" do
    before { VCR.insert_cassette "current_tips" }
    after { VCR.eject_cassette }
    let(:current_tips) do
      [
        {"amount"=>"1.00", "platform"=>"gittip", "username"=>"whit537"},
        {"amount"=>"0.25", "platform"=>"gittip", "username"=>"JohnKellyFerguson"}
      ]
    end

    describe "#current_tips" do
      it "returns the correct array of current tips" do
        expect(client.current_tips).to eq (current_tips)
      end
    end

    describe "#current_tips_total" do
      it "returns the correct total of current tips" do
        expect(client.current_tips_total).to eq(1.25)
      end
    end
  end #GET Requests

  describe "POST Requests" do
    describe "#update_tips" do
      before { VCR.insert_cassette "update_tips" }
      after { VCR.eject_cassette }

      let(:multiple_tips) do
        [
          {"amount"=>"1.00", "platform"=>"gittip", "username"=>"whit537"},
          {"amount"=>"0.25", "platform"=>"gittip", "username"=>"JohnKellyFerguson"},
          {"amount"=>"1.00", "platform"=>"gittip", "username"=>"Gittip"}
        ]
      end

      it "updates the correct tip information" do
        expect(client.update_tips(multiple_tips)).to eq(multiple_tips)
      end
    end #update_tips

    describe "#update_tips_and_prune" do
      before { VCR.insert_cassette "update_and_prune" }
      after { VCR.eject_cassette }

      let(:previous_tips) do
        [
          {"amount"=>"1.00", "platform"=>"gittip", "username"=>"whit537"},
          {"amount"=>"0.25", "platform"=>"gittip", "username"=>"JohnKellyFerguson"},
          {"amount"=>"1.00", "platform"=>"gittip", "username"=>"Gittip"}
        ]
      end
      let(:pruned_tips) do
        [
          {"amount"=>"1.00", "platform"=>"gittip", "username"=>"whit537"},
          {"amount"=>"0.25", "platform"=>"gittip", "username"=>"JohnKellyFerguson"}
        ]
      end

      it "removes tips that were not part of the request" do
        expect { client.update_tips_and_prune(pruned_tips) }
          .to change { client.current_tips }
          .to(pruned_tips)
      end
    end

  end #POST Requests
end