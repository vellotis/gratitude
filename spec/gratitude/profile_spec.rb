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

    context "a fully completed profile" do

      before do
        VCR.insert_cassette "complete_profile"
      end

      after do
        VCR.eject_cassette
      end

      let(:complete_profile) { Gratitude::Profile.new("whit537") }

      it "should set the correct username" do
        expect(complete_profile.username).to eq("whit537")
      end

      it "should respond to #response" do
        expect(complete_profile).to respond_to(:response)
      end

      describe "#avatar_url" do
        it "should return the correct avatar url" do
          expect(complete_profile.avatar_url).to eq("https://www.gravatar.com/avatar/fb054b407a6461e417ee6b6ae084da37.jpg?s=128")
        end
      end

      describe "#bitbucket_api_url" do
        it "should return the correct bitbucket api url" do
          expect(complete_profile.bitbucket_api_url).to eq("https://bitbucket.org/api/1.0/users/whit537")
        end
      end

      describe "#bitbucket_username" do
        it "should return the correct bitbucket username" do
          expect(complete_profile.bitbucket_username).to eq("whit537")
        end
      end

      describe "#bountysource_api_url" do
        it "should return the correct bountysource api url" do
          expect(complete_profile.bountysource_api_url).to eq("https://api.bountysource.com/users/whit537")
        end
      end

      describe "#bountysource_username" do
        it "should return the correct bountysource username" do
          expect(complete_profile.bountysource_username).to eq("whit537")
        end
      end

      describe "#github_api_url" do
        it "should return the correct github api url" do
          expect(complete_profile.github_api_url).to eq("https://api.github.com/users/whit537")
        end
      end

      describe "#github_username" do
        it "should return the correct github username" do
          expect(complete_profile.github_username).to eq("whit537")
        end
      end

      describe "#twitter_api_url" do
        it "should return the correct twitter api url" do
          expect(complete_profile.twitter_api_url).to eq("https://api.twitter.com/1.1/users/show.json?id=34175404&include_entities=1")
        end
      end
      
      describe "#twitter_username" do
        it "should return nil" do
          expect(complete_profile.twitter_username).to be(nil)
        end
      end

      describe "#amount_giving" do
        it "should be a float" do
          expect(complete_profile.amount_giving.class).to be(Float)
        end

        it "should return the correct amount giving" do
          expect(complete_profile.amount_giving).to eq(101.41)
        end
      end

      describe "#amount_receiving" do
        it "should be a float" do
          expect(complete_profile.amount_receiving.class).to be(Float)
        end

        it "should return the correct amount amount receiving" do
          expect(complete_profile.amount_receiving).to eq(434.25)
       end
      end

      describe "#goal" do
        it "should return the correct goal" do
          expect(complete_profile.goal).to be(nil)
        end
      end

      describe "#number" do
        it "should return the correct number" do
          expect(complete_profile.number).to eq("singular")
        end
      end

      describe "#id" do
        it "should be a fixnum" do
          expect(complete_profile.id.class).to be(Fixnum)
        end

        it "should return the correct id number" do
          expect(complete_profile.id).to eq(1451)
        end
      end

    end

    context "an account that registered through twitter and linked no other accounts" do
      
      before do
        VCR.insert_cassette "incomplete_profile"
      end

      after do
        VCR.eject_cassette
      end

      let(:incomplete_profile) { Gratitude::Profile.new("gratitude_test") }


      describe "#bitbucket_api_url" do
        it "should return nil" do
          expect(incomplete_profile.bitbucket_api_url).to be(nil)
        end
      end

      describe "#bitbucket_username" do
        it "should return nil" do
          expect(incomplete_profile.bitbucket_username).to be(nil)
        end
      end

      describe "#bountysource_api_url" do
        it "should return nil" do
          expect(incomplete_profile.bountysource_api_url).to be(nil)
        end
      end

      describe "#bountysource_username" do
        it "should return nil" do
          expect(incomplete_profile.bountysource_username).to be(nil)
        end
      end

      describe "#github_api_url" do
        it "should return nil" do
          expect(incomplete_profile.github_api_url).to be(nil)
        end
      end

      describe "#github_username" do
        it "should return nil" do
          expect(incomplete_profile.github_username).to be(nil)
        end
      end

      describe "#goal" do
        context "a user who has defined themselves as a patron" do
          it "should return nil" do
            expect(incomplete_profile.goal).to eq(nil)
          end
        end
      end

    end

    context "a profile that has defined a gittip goal" do

      before do
        VCR.insert_cassette "goal_profile"
      end

      after do
        VCR.eject_cassette
      end


      let(:goal_profile) { Gratitude::Profile.new("johnkellyferguson") }

      describe "#goal" do
        it "should return the correct goal amount" do
          expect(goal_profile.goal).to eq(5.00)
        end
      end

    end


  end    

end