require "spec_helper"

describe Gratitude::Client::Tips do
  let(:username) { "gratitude_test" }
  let(:api_key) { "5962b93a-5bf7-4cb6-ae6f-aa4114c5e4f2" }
  let(:client) do
    Gratitude::Client.new(:username => username, :api_key => api_key)
  end

  describe "methods that do not interact with the API" do

    describe "#tips_url" do
      it "returns the correct tips_url" do
        expect(client.tips_url)
          .to eq("https://www.gittip.com/gratitude_test/tips.json")
      end
    end

    describe "#authorization" do
      it "returns the correct authorization hash" do
        expect(client.authorization).to eq({ :username =>  api_key })
      end
    end

    describe "#tip_hash_based_upon(username, amount)" do
      it "returns the correct tip hash when given an integer" do
        expect(client.tip_hash_based_upon("whit537", 1)).to eq(
          { "amount" => "1", "platform" => "gittip", "username" => "whit537" })
      end

      it "returns the correct tip hash when given an integer in a string" do
        expect(client.tip_hash_based_upon("whit537", "1")).to eq(
          { "amount" => "1", "platform" => "gittip", "username" => "whit537" })
      end

      it "returns the correct tip hash when given a float" do
        expect(client.tip_hash_based_upon("whit537", 0.25)).to eq(
          { "amount" => "0.25", "platform" => "gittip", "username" => "whit537" })
      end

      it "returns the correct tip hash when given a float" do
        expect(client.tip_hash_based_upon("whit537", "0.25")).to eq(
          { "amount" => "0.25", "platform" => "gittip", "username" => "whit537" })
      end
    end #single_tip_hash

    describe "#prepared_tips_array" do

      context "when using symbols as keys" do
        it "returns the correct tips array when given an array with one tip" do
          expect(client.prepared_tips_array([:username => "whit537", :amount => "1"])).to eq(
            [{ "amount" => "1", "platform" => "gittip", "username" => "whit537" }])
        end

        it "returns the correct tips array when given an array with two tips" do
          expect(client.prepared_tips_array([
            { :username => "whit537", :amount => "1" },
            { :username => "JohnKellyFerguson", :amount => "0.25" }
          ])).to eq([
            { "amount" => "1", "platform" => "gittip", "username" => "whit537" },
            { "amount" => "0.25", "platform" => "gittip", "username" => "JohnKellyFerguson" }
            ])
        end
      end # symbols as keys

      context "when using strings as keys" do
        it "returns the correct tips array when given an array with one tip" do
          expect(client.prepared_tips_array(["username" => "whit537", "amount" => "1"])).to eq(
            [{ "amount" => "1", "platform" => "gittip", "username" => "whit537" }])
        end

        it "returns the correct tips array when given an array with one tip" do
              expect(client.prepared_tips_array([
                { "username" => "whit537", "amount" => "1" },
                { "username" => "JohnKellyFerguson", "amount" => "0.25" }
              ])).to eq([
                { "amount" => "1", "platform" => "gittip", "username" => "whit537" },
                { "amount" => "0.25", "platform" => "gittip", "username" => "JohnKellyFerguson" }
                ])
        end
      end # strings as keys

    end #tips_array

  end # methods that do not interact with the API

  describe "authentication and api requests" do
    context "GET Requests" do
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

    context "POST Requests" do
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

        # context "when passing in a non-existent username" do
        #   before do
        #     VCR.insert_cassette "post_tip_error"
        #   end

        #   after do
        #     VCR.eject_cassette
        #   end

        #   it "raises an error" do
        #     expect(
        #       client.update_tips(
        #         [ {:username => "not_a_real_user", :amount => "20"} ]
        #         ).parsed_response).to eq()
        #   end
        # end # non-existent username

      end #update_tips

      describe "#update_tips_and_prune" do

      end

    end #POST Requests

  end # authentication and api requests
end