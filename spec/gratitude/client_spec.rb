require "spec_helper"

describe Gratitude::Client do

  describe "default attributes" do

    it "should include httparty methods" do
      Gratitude::Client.should include(HTTParty)
    end

    it "should include tips methods" do
      Gratitude::Client.should include(Gratitude::Client::Tips)
    end

  end # default attributes

  describe "initialization" do
    let(:username) { "JohnKellyFerguson"}
    let(:api_key) { "this_is_an_api_key"}

    subject { Gratitude::Client.new(:username => username, :api_key => api_key) }

    its(:username) { should == username }
    its(:api_key) { should == api_key }

  end


end