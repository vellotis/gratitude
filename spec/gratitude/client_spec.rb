require "spec_helper"

describe Gratitude::Client do

  describe "default attributes" do
    it "includes httparty methods" do
      expect(Gratitude::Client).to include(HTTParty)
    end

    it "includes tips methods" do
      expect(Gratitude::Client).to include(Gratitude::Client::Tips)
    end
  end

  describe "initialization" do
    let(:username) { "JohnKellyFerguson"}
    let(:api_key) { "this_is_an_api_key"}
    let(:client) do
      Gratitude::Client.new(:username => username, :api_key => api_key)
    end

    it "assigns the correct username" do
      expect(client.username).to eq(username)
    end

    it "assigns the correct api key" do
      expect(client.api_key).to eq(api_key)
    end
  end

end
