require "spec_helper"

describe Gratitude::Client::Tips do
  let(:username) { "gratitude_test" }
  let(:api_key) { "5962b93a-5bf7-4cb6-ae6f-aa4114c5e4f2" }
  let(:client) do
    Gratitude::Client.new(:username => username, :api_key => api_key)
  end

  describe "GET Requests" do
    before { VCR.insert_cassette "get_tips" }
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
      context "when updating a single tip" do
        before { VCR.insert_cassette "post_single_tip" }
        after { VCR.eject_cassette }
        let(:single_tip_response) do
          [{"amount"=>"5", "platform"=>"gittip", "username"=>"whit537"}]
        end

        it "updates the correct tip information" do
          expect(
            client.update_tips(
              [{ :username => "whit537", :amount => "5" }]
              ).parsed_response).to eq(single_tip_response)
        end
      end #update_tips

      context "when updating multiple tips" do
        before { VCR.insert_cassette "post_multiple_tips" }
        after { VCR.eject_cassette }

        let(:multi_tip_response) do
          [
            {"amount"=>"10", "platform"=>"gittip", "username"=>"whit537"},
            {"amount"=>"4", "platform"=>"gittip", "username"=>"JohnKellyFerguson"}
          ]
        end

        it "updates the correct tip information" do
          expect(
            client.update_tips(
              [{ :username => "whit537", :amount => "10" },
               { :username => "JohnKellyFerguson", :amount => "4"}]
              ).parsed_response).to eq(multi_tip_response)
        end
      end # updating multiple tips

    end #update_tips

    describe "#update_tips_and_prune" do
      let(:previous_tips) do
        [
          {"amount"=>"1.00", "platform"=>"gittip", "username"=>"whit537"},
          {"amount"=>"0.25", "platform"=>"gittip", "username"=>"JohnKellyFerguson"}
        ]
      end
      let(:pruned_tips) do
        [{ "amount"=>"1.00", "platform"=>"gittip", "username"=>"whit537" }]
      end

      before { VCR.insert_cassette "update_and_prune" }
      after { VCR.eject_cassette }

      it "removes tips that were not part of the request" do
        expect { client.update_tips_and_prune(pruned_tips) }
          .to change { client.current_tips }
          .from(previous_tips).to(pruned_tips)
      end

    end

  end #POST Requests
end