require "spec_helper"

describe Gratitude::Profile do

  describe "default attributes" do
    it "includes Gratitude::Connection" do
      expect(Gratitude::Profile).to include(Gratitude::Connection)
    end
  end

  describe "instance methods" do

    context "a fully completed profile" do
      before { VCR.insert_cassette "complete_profile" }
      after { VCR.eject_cassette }
      let(:complete_profile) { Gratitude::Profile.new("whit537") }

      it "sets the correct username" do
        expect(complete_profile.username).to eq("whit537")
      end

      describe "#avatar_url" do
        it "returns the correct avatar url" do
          expect(complete_profile.avatar_url)
            .to eq("https://www.gravatar.com/avatar/fb054b407a6461e417ee6b6ae084da37.jpg?s=128")
        end

        it "returns the same value as its alias: #avatar" do
          expect(complete_profile.avatar_url).to eq(complete_profile.avatar)
        end
      end

      describe "#bitbucket_api_url" do
        it "returns the correct bitbucket api url" do
          expect(complete_profile.bitbucket_api_url)
            .to eq("https://bitbucket.org/api/1.0/users/whit537")
        end

        it "returns the same value as its alias: #bitbucket" do
          expect(complete_profile.bitbucket_api_url).to eq(complete_profile.bitbucket)
        end
      end

      describe "#bitbucket_username" do
        it "returns the correct bitbucket username" do
          expect(complete_profile.bitbucket_username).to eq("whit537")
        end
      end

      describe "#bountysource_api_url" do
        it "returns the correct bountysource api url" do
          expect(complete_profile.bountysource_api_url)
            .to eq("https://api.bountysource.com/users/whit537")
        end
      end

      describe "#bountysource_username" do
        it "returns the correct bountysource username" do
          expect(complete_profile.bountysource_username).to eq("whit537")
        end
      end

      describe "#github_api_url" do
        it "returns the correct github api url" do
          expect(complete_profile.github_api_url)
            .to eq("https://api.github.com/users/whit537")
        end

        it "returns the same value as its alias: #github" do
          expect(complete_profile.github_api_url).to eq(complete_profile.github)
        end
      end

      describe "#github_username" do
        it "returns the correct github username" do
          expect(complete_profile.github_username).to eq("whit537")
        end
      end

      describe "#twitter_api_url" do
        it "returns the correct twitter api url" do
          expect(complete_profile.twitter_api_url)
            .to eq("https://api.twitter.com/1.1/users/show.json?id=34175404&include_entities=1")
        end

        it "returns the same value as its alias: #twitter" do
          expect(complete_profile.twitter_api_url).to eq(complete_profile.twitter)
        end
      end

      describe "#twitter_username" do
        it "returns nil" do
          expect(complete_profile.twitter_username).to be(nil)
        end
      end

      describe "#amount_giving" do
        it "returns a float" do
          expect(complete_profile.amount_giving.class).to be(Float)
        end

        it "returns the correct amount giving" do
          expect(complete_profile.amount_giving).to eq(101.41)
        end

        it "returns the same value as its alias: #giving" do
          expect(complete_profile.amount_giving).to eq(complete_profile.giving)
        end
      end

      describe "#amount_receiving" do
        it "returns a float" do
          expect(complete_profile.amount_receiving.class).to be(Float)
        end

        it "returns the correct amount amount receiving" do
          expect(complete_profile.amount_receiving).to eq(434.25)
        end

        it "returns the same value as its alias: #receiving" do
          expect(complete_profile.amount_receiving)
            .to eq(complete_profile.receiving)
        end
      end

      describe "#goal" do
        it "returns the correct goal" do
          expect(complete_profile.goal).to be(nil)
        end
      end

      describe "#account_type" do
        it "returns the correct account_type" do
          expect(complete_profile.account_type).to eq("singular")
        end

        it "returns the same value as its alias: #number" do
          expect(complete_profile.account_type).to eq(complete_profile.number)
        end
      end

      describe "#id" do
        it "returns a fixnum" do
          expect(complete_profile.id.class).to be(Fixnum)
        end

        it "returns the correct id number" do
          expect(complete_profile.id).to eq(1451)
        end
      end

    end # a fully completed profile

    context "an account with only twitter as a linked account" do
      before { VCR.insert_cassette "incomplete_profile" }
      after { VCR.eject_cassette }
      let(:incomplete_profile) { Gratitude::Profile.new("gratitude_test") }

      describe "#bitbucket_api_url" do
        it "returns nil" do
          expect(incomplete_profile.bitbucket_api_url).to be(nil)
        end
      end

      describe "#bitbucket_username" do
        it "returns nil" do
          expect(incomplete_profile.bitbucket_username).to be(nil)
        end
      end

      describe "#bountysource_api_url" do
        it "returns nil" do
          expect(incomplete_profile.bountysource_api_url).to be(nil)
        end
      end

      describe "#bountysource_username" do
        it "returns nil" do
          expect(incomplete_profile.bountysource_username).to be(nil)
        end
      end

      describe "#github_api_url" do
        it "returns nil" do
          expect(incomplete_profile.github_api_url).to be(nil)
        end
      end

      describe "#github_username" do
        it "returns nil" do
          expect(incomplete_profile.github_username).to be(nil)
        end
      end

      describe "#goal" do
        context "a user who has defined themselves as a patron" do
          it "returns nil" do
            expect(incomplete_profile.goal).to eq(nil)
          end
        end
      end

    end # an incomplete profile

    context "a profile that has defined a gittip goal" do
      before { VCR.insert_cassette "goal_profile" }
      after { VCR.eject_cassette }
      let(:goal_profile) { Gratitude::Profile.new("JohnKellyFerguson") }

      describe "#goal" do
        it "returns the correct goal amount" do
          expect(goal_profile.goal).to eq(5.00)
        end
      end
    end # a profile with a gittip goal

  end # instance methods

end
