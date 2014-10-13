# encoding: utf-8

require "spec_helper"

class TestObject
  include Gratitude::Connection
end

describe TestObject do
  let(:test_object) { TestObject.new }

  describe "#faraday" do
    it "is an instance of Faraday::Connection" do
      expect(test_object.faraday.class).to eq(Faraday::Connection)
    end

    it "sets the correct gratipay base url" do
      expect(test_object.faraday.url_prefix.to_s)
        .to eq("https://gratipay.com/")
    end
  end
end
