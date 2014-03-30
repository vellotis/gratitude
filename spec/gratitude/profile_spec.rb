require "spec_helper"

describe Gratitude::Profile do

  describe "default attributes" do
    it "includes Gratitude::Connection" do
      expect(Gratitude::Profile).to include(Gratitude::Connection)
    end
  end

  describe "instance methods" do
    before { VCR.insert_cassette "profiles" }
    after { VCR.eject_cassette }
    let(:complete_profile) { Gratitude::Profile.new("JohnKellyFerguson") }
    let(:incomplete_profile) { Gratitude::Profile.new("gratitude_test") }
    let(:no_twitter_profile) { Gratitude::Profile.new("goya") }

    it "sets the correct username" do
      expect(complete_profile.username).to eq("JohnKellyFerguson")
    end

    describe "json response" do
      it "returns the correct keys in the json hash" do
        expect(complete_profile.send(:response_body).keys)
          .to eq(
            [
              "avatar",
              "bitcoin",
              "elsewhere",
              "giving",
              "goal",
              "id",
              "npatrons",
              "number",
              "on",
              "receiving",
              "username"
              ]
            )
      end
    end

    describe "#avatar_url" do
      it "returns a string" do
        expect(complete_profile.avatar_url.class).to be(String)
      end

      it "returns the same value as its alias: #avatar" do
        expect(complete_profile.avatar_url).to eq(complete_profile.avatar)
      end
    end

    describe "#bitcoin" do
      context "a user with an associated bitcoin address" do
        it "returns a string" do
          expect(complete_profile.bitcoin.class).to be(String)
        end
      end

      context "a user without an associated bitcoin address" do
        it "returns a string" do
          expect(incomplete_profile.bitcoin).to be(nil)
        end
      end
    end

    describe "#bitbucket" do
      context "a user with an associated bitbucket account" do
        it "returns a hash" do
          expect(complete_profile.bitbucket.class).to be(Hash)
        end
      end

      context "a user without an associated bitbucket acount" do
        it "returns a string" do
          expect(incomplete_profile.bitbucket).to be(nil)
        end
      end
    end

    describe "#bitbucket_username" do
      context "a user with an associated bitbucket account" do
        it "returns a string" do
          expect(complete_profile.bitbucket_username.class).to be(String)
        end
      end

      context "a user without an associated bitbucket acount" do
        it "returns a string" do
          expect(incomplete_profile.bitbucket_username).to be(nil)
        end
      end
    end

    describe "#bountysource" do
      context "a user with an associated bountysource account" do
        it "returns a hash" do
          expect(complete_profile.bountysource.class).to be(Hash)
        end
      end

      context "a user without an associated bountysource acount" do
        it "returns a string" do
          expect(incomplete_profile.bountysource).to be(nil)
        end
      end
    end

    describe "#bountysource_username" do
      context "a user with an associated bountysource account" do
        it "returns a string" do
          expect(complete_profile.bountysource_username.class).to be(String)
        end
      end

      context "a user without an associated bountysource acount" do
        it "returns a string" do
          expect(incomplete_profile.bountysource_username).to be(nil)
        end
      end
    end

    describe "#github" do
      context "a user with an associated github account" do
        it "returns a hash" do
          expect(complete_profile.github.class).to be(Hash)
        end
      end

      context "a user without an associated github acount" do
        it "returns a string" do
          expect(incomplete_profile.github).to be(nil)
        end
      end
    end

    describe "#github_username" do
      context "a user with an associated github account" do
        it "returns a string" do
          expect(complete_profile.github_username.class).to be(String)
        end
      end

      context "a user without an associated github acount" do
        it "returns a string" do
          expect(incomplete_profile.github_username).to be(nil)
        end
      end
    end

    describe "#openstreetmap" do
      context "a user with an associated openstreetmap account" do
        it "returns a hash" do
          expect(complete_profile.openstreetmap.class).to be(Hash)
        end
      end

      context "a user without an associated openstreetmap acount" do
        it "returns a string" do
          expect(incomplete_profile.openstreetmap).to be(nil)
        end
      end
    end

    describe "#openstreetmap_username" do
      context "a user with an associated openstreetmap account" do
        it "returns a string" do
          expect(complete_profile.openstreetmap_username.class).to be(String)
        end
      end

      context "a user without an associated openstreetmap acount" do
        it "returns a string" do
          expect(incomplete_profile.openstreetmap_username).to be(nil)
        end
      end
    end

    describe "#twitter" do
      context "a user with an associated twitter account" do
        it "returns a hash" do
          expect(complete_profile.twitter.class).to be(Hash)
        end
      end

      context "a user without an associated twitter acount" do
        it "returns a string" do
          expect(no_twitter_profile.twitter).to be(nil)
        end
      end
    end

    describe "#twitter_username" do
      context "a user with an associated twitter account" do
        it "returns a string" do
          expect(complete_profile.twitter_username.class).to be(String)
        end
      end

      context "a user without an associated twitter acount" do
        it "returns a string" do
          expect(no_twitter_profile.twitter_username).to be(nil)
        end
      end
    end

    describe "#venmo" do
      context "a user with an associated venmo account" do
        it "returns a hash" do
          expect(complete_profile.venmo.class).to be(Hash)
        end
      end
    end

    describe "#venmo_username" do
      context "a user with an associated venmo account" do
        it "returns a string" do
          expect(complete_profile.venmo_username.class).to be(String)
        end
      end

      context "a user without an associated venmo acount" do
        it "returns a string" do
          expect(incomplete_profile.openstreetmap_username).to be(nil)
        end
      end
    end

    describe "#amount_giving" do
      it "returns a float" do
        expect(complete_profile.amount_giving.class).to be(Float)
      end

      it "returns the same value as its alias: #giving" do
        expect(complete_profile.amount_giving).to eq(complete_profile.giving)
      end
    end

    describe "#amount_receiving" do
      it "returns a float" do
        expect(complete_profile.amount_receiving.class).to be(Float)
      end

      it "returns the same value as its alias: #receiving" do
        expect(complete_profile.amount_receiving)
          .to eq(complete_profile.receiving)
      end
    end

    describe "#goal" do
      context "a user who has defined a goal" do
        it "returns a Float" do
          expect(complete_profile.goal.class).to be(Float)
        end
      end

      context "a user who has not defined a goal" do
        it "returns nil" do
          expect(incomplete_profile.goal).to be(nil)
        end
      end
    end

    describe "#account_type" do
      it "returns a string" do
        expect(complete_profile.account_type.class).to be(String)
      end

      it "returns the same value as its alias: #number" do
        expect(complete_profile.account_type).to eq(complete_profile.number)
      end
    end

    describe "#id" do
      it "returns a fixnum" do
        expect(complete_profile.id.class).to be(Fixnum)
      end
    end

    describe "#number_of_patrons" do
      it "returns a Fixnum" do
        expect(complete_profile.number_of_patrons.class).to be(Fixnum)
      end

      it "returns the same value as its alias: #npatrons" do
        expect(complete_profile.number_of_patrons)
          .to eq(complete_profile.npatrons)
      end
    end

    describe "#on" do
      it "returns a string" do
        expect(complete_profile.on.class).to be(String)
      end
    end

  end # instance methods

end
