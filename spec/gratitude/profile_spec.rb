require "spec_helper"

describe Gratitude::Profile do

  describe "default attributes" do

    it "should include httparty methods" do
      Gratitude::Profile.should include(HTTParty)
    end

    it "should have the base url set to the API endpoint" do
      expect(Gratitude::Profile.base_uri).to eq("https://www.gittip.com")
    end

    it "should have the correct uri suffix" do
      expect(Gratitude::Profile::URI_SUFFIX).to eq("/public.json")
    end

  end

  describe "instance methods" do
    before do
      VCR.insert_cassette "profile"
    end

    after do
      VCR.eject_cassette
    end

    let(:profile) { Gratitude::Profile.new("whit537") }

    it "should set the correct username" do
      expect(profile.username).to eq("whit537")
    end

    it "should respond to #response" do
      expect(profile).to respond_to(:response)
    end

    describe "#avatar_url" do
      it "should return the correct avatar url" do
        expect(profile.avatar_url).to eq("https://www.gravatar.com/avatar/fb054b407a6461e417ee6b6ae084da37.jpg?s=128")
      end
    end

    describe "#bitbucket_api_url" do
      it "should return the correct bitbucket api url" do
        expect(profile.bitbucket_api_url).to eq("https://bitbucket.org/api/1.0/users/whit537")
      end
    end

    describe "#bitbucket_username" do
      it "should return the correct bitbucket username" do
        expect(profile.bitbucket_username).to eq("whit537")
      end
    end

    describe "#bountysource_api_url" do
      it "should return the correct the bountysource api url" do
        expect(profile.bountysource_api_url).to eq("https://api.bountysource.com/users/whit537")
      end
    end

    describe "#bountysource_username" do
      it "should return the correct bountysource username" do
        expect(profile.bountysource_username).to eq("whit537")
      end
    end

    describe "#github_api_url" do
      it "should return the correct github api url" do
        expect(profile.github_api_url).to eq("https://api.github.com/users/whit537")
      end
    end

    describe "#github_username" do
      it "should return the correct github username" do
        expect(profile.github_username).to eq("whit537")
      end
    end

    describe "#twitter_api_url" do
      it "should return the correct twitter api url" do
        expect(profile.twitter_api_url).to eq("https://api.twitter.com/1.1/users/show.json?id=34175404&include_entities=1")
      end
    end
    
    describe "#twitter_username" do
      it "should return nil" do
        expect(profile.twitter_username).to be(nil)
      end
    end

    describe "#amount_giving" do

      it "should be a float" do
        expect(profile.amount_giving.class).to be(Float)
      end

      it "should return the correct amount giving" do
        expect(profile.amount_giving).to eq(101.41)
      end

    end

    describe "#amount_receiving" do

      it "should be a float" do
        expect(profile.amount_receiving.class).to be(Float)
      end

      it "should return the correct amount amount receiving" do
        expect(profile.amount_receiving).to eq(433.00)
      end

    end

    describe "#goal" do
      it "should return the correct goal" do
        expect(profile.goal).to be(nil)
      end
    end

    describe "#number" do
      it "should return the correct number" do
        expect(profile.number).to eq("singular")
      end
    end

    describe "#id" do

      it "should be a fixnum" do
        expect(profile.id.class).to be(Fixnum)
      end

      it "should return the correct id number" do
        expect(profile.id).to eq(1451)
      end
    end


  end

end