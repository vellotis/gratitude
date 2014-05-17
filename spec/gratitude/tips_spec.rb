require "spec_helper"

describe Gratitude::Client::Tips do
  let(:username) { "gratitude_test" }
  let(:api_key) { "5962b93a-5bf7-4cb6-ae6f-aa4114c5e4f2" }
  let(:client) do
    Gratitude::Client.new(username: username, api_key: api_key)
  end
  let(:unauthenticated_client) do
    Gratitude::Client.new(username: username, api_key: "bad_key")
  end
  let(:current_tips) do
    [
      { "amount" => "1.00",
        "platform" => "gittip",
        "username" => "whit537"
      },
      { "amount" => "0.25",
        "platform" => "gittip",
        "username" => "JohnKellyFerguson"
      }
    ]
  end

  describe "GET Requests" do
    describe "#current_tips" do
      context "when properly authenticated" do
        before { VCR.insert_cassette "current_tips" }
        before { client.update_tips(current_tips) }
        after { VCR.eject_cassette }
        it "returns the correct array of current tips" do
          expect(client.current_tips).to eq(current_tips)
        end
      end

      context "when not properly authenticated" do
        before { VCR.insert_cassette "current_tips_not_authenticated" }
        after { VCR.eject_cassette }

        it "raises an AuthenticationError" do
          expect { unauthenticated_client.current_tips }
            .to raise_error(Gratitude::AuthenticationError)
        end
      end
    end

    describe "#current_tips_total" do
      before { VCR.insert_cassette "current_tips" }
      after { VCR.eject_cassette }

      it "returns the correct total of current tips" do
        expect(client.current_tips_total).to eq(1.25)
      end
    end
  end # GET Requests

  describe "POST Requests" do
    describe "#update_tips" do
      let(:multiple_tips) do
        [
          { "amount" => "1.00",
            "platform" => "gittip",
            "username" => "whit537"
          },
          { "amount" => "0.25",
            "platform" => "gittip",
            "username" => "JohnKellyFerguson"
          },
          {
            "amount" => "1.00",
            "platform" => "gittip",
            "username" => "Gittip"
          }
        ]
      end

      context "when not properly authenticated" do
        before { VCR.insert_cassette "update_tips_not_authenticated" }
        after { VCR.eject_cassette }

        it "raises an AuthenticationError" do
          expect { unauthenticated_client.update_tips(multiple_tips) }
            .to raise_error(Gratitude::AuthenticationError)
        end
      end

      context "when there are bad request parameters" do
        before { VCR.insert_cassette "update_bad_request" }
        after { VCR.eject_cassette }
        let(:incorrect_tips) do
          [
            {
              "amount" => "1.00",
              "platform" => "gittip",
              "username" => "not_a_user_so_fake"
            },
            {
              "amount" => "0.25",
              "platform" => "gittip",
              "username" => "lol_this_will_be_an_error"
            },
            {
              "amount" => "1.00",
              "platform" => "gittip",
              "username" => "whit537"
            },
            {
              "amount" => "0.25",
              "platform" => "gittip",
              "username" => "JohnKellyFerguson"
            }
          ]
        end

        it "raises a TipUpdateError" do
          expect { client.update_tips(incorrect_tips) }
            .to raise_error(Gratitude::TipUpdateError)
        end
      end

      context "when properly authenticated" do
        before { VCR.insert_cassette "update_tips" }
        after { VCR.eject_cassette }

        it "updates the correct tip information" do
          expect(client.update_tips(multiple_tips)).to eq(multiple_tips)
        end
      end
    end # update_tips

    describe "#update_tips_and_prune" do
      let(:pruned_tips) do
        [
          {
            "amount" => "1.00",
            "platform" => "gittip",
            "username" => "whit537"
          },
          {
            "amount" => "0.25",
            "platform" => "gittip",
            "username" => "JohnKellyFerguson"
          }
        ]
      end

      context "when properly authenticated" do
        before { VCR.insert_cassette "update_and_prune" }
        after { VCR.eject_cassette }
        let(:previous_tips) do
          [
            {
              "amount" => "1.00",
              "platform" => "gittip",
              "username" => "Gittip"
            },
            {
              "amount" => "1.00",
              "platform" => "gittip",
              "username" => "whit537"
            },
            {
              "amount" => "0.25",
              "platform" => "gittip",
              "username" => "JohnKellyFerguson"
            }
          ]
        end

        it "removes tips that were not part of the request" do
          expect { client.update_tips_and_prune(pruned_tips) }
            .to change { client.current_tips }
            .from(previous_tips)
            .to(pruned_tips)
        end
      end

      context "when there are bad request parameters" do
        before { VCR.insert_cassette "update_and_prune_bad_request" }
        after { VCR.eject_cassette }
        let(:incorrect_tips) do
          [
            { "amount" => "1.00",
              "platform" => "gittip",
              "username" => "not_a_user_so_fake"
            },
            {
              "amount" => "0.25",
              "platform" => "gittip",
              "username" => "will_be_an_error"
            }
          ]
        end

        it "raises a TipUpdateError" do
          expect { client.update_tips_and_prune(incorrect_tips) }
            .to raise_error(Gratitude::TipUpdateError)
        end
      end

      context "when not properly authenticated" do
        before { VCR.insert_cassette "prune_tips_not_authenticated" }
        after { VCR.eject_cassette }

        it "raises an AuthenticationError" do
          expect { unauthenticated_client.update_tips_and_prune(pruned_tips) }
            .to raise_error(Gratitude::AuthenticationError)
        end
      end
    end
  end # POST Requests
end
