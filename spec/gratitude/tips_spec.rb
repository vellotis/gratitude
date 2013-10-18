require "spec_helper"

describe Gratitude::Client::Tips do

  let(:username) { "gratitude_test" }
  let(:api_key) { "5962b93a-5bf7-4cb6-ae6f-aa4114c5e4f2" }

  let(:client) { Gratitude::Client.new(:username => username, :api_key => api_key) }

  describe "#tips_url" do
    it "returns the correct tips_url" do
      expect(client.tips_url).to eq("https://www.gittip.com/gratitude_test/tips.json")
    end
  end

  describe "#authorization" do
    it "returns the correct authorization hash" do
      expect(client.authorization).to eq({ :basic_auth => { :username =>  api_key } })
    end
  end


  describe "authentication and api requests" do

    let(:current_tips) { [{"amount"=>"1.00", "platform"=>"gittip", "username"=>"whit537"},
                          {"amount"=>"0.25", "platform"=>"gittip", "username"=>"JohnKellyFerguson"}] }

    before do
      VCR.insert_cassette "tips"
    end

    after do
      VCR.eject_cassette
    end

    describe "#current_tips" do
      it "returns the correct array of current tips" do
        expect(client.current_tips).to eq (current_tips)
      end
    end

    describe "#update_tip" do
    end

    describe "#update_tips" do
    end

    describe "#update_tips_and_prune" do
    end


  end # authentication and api requests
end