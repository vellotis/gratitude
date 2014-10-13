# encoding: utf-8

require "spec_helper"

describe Gratitude::Profile do

  describe "default attributes" do
    it "includes Gratitude::Connection" do
      expect(Gratitude::Profile).to include(Gratitude::Connection)
    end
  end

  describe "instance methods" do
    context "when the requested Gittip user does not exist" do
      it "raises a UsernameNotFoundError" do
        expect { Gratitude::Profile.new("non_existing_user").send(:response) }
          .to raise_error(Gratitude::UsernameNotFoundError)
      end
    end

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
            %w(
              avatar
              bitcoin
              elsewhere
              giving
              goal
              id
              npatrons
              number
              on
              receiving
              username
            )
          )
      end
    end

    describe "#avatar" do
      it "returns a string" do
        expect(complete_profile.avatar).to be_a(String)
      end

      it "returns the same value as its alias: #avatar_url" do
        expect(complete_profile.avatar).to eq(complete_profile.avatar_url)
      end
    end

    describe "#bitcoin" do
      context "a user with an associated bitcoin address" do
        it "returns a string" do
          expect(complete_profile.bitcoin).to be_a(String)
        end
      end

      context "a user without an associated bitcoin address" do
        it "returns a string" do
          expect(incomplete_profile.bitcoin).to be_nil
        end
      end
    end

    describe "#bitbucket" do
      context "a user with an associated bitbucket account" do
        it "returns a hash" do
          expect(complete_profile.bitbucket).to be_a(Hash)
        end
      end

      context "a user without an associated bitbucket acount" do
        it "returns a string" do
          expect(incomplete_profile.bitbucket).to be_nil
        end
      end
    end

    describe "#bitbucket_username" do
      context "a user with an associated bitbucket account" do
        it "returns a string" do
          expect(complete_profile.bitbucket_username).to be_a(String)
        end
      end

      context "a user without an associated bitbucket acount" do
        it "returns a string" do
          expect(incomplete_profile.bitbucket_username).to be_nil
        end
      end
    end

    describe "#bountysource" do
      context "a user with an associated bountysource account" do
        it "returns a hash" do
          expect(complete_profile.bountysource).to be_a(Hash)
        end
      end

      context "a user without an associated bountysource acount" do
        it "returns a string" do
          expect(incomplete_profile.bountysource).to be_nil
        end
      end
    end

    describe "#bountysource_username" do
      context "a user with an associated bountysource account" do
        it "returns nil" do
          expect(complete_profile.bountysource_username).to be_nil
        end
      end

      context "a user without an associated bountysource acount" do
        it "returns a string" do
          expect(incomplete_profile.bountysource_username).to be_nil
        end
      end
    end

    describe "#github" do
      context "a user with an associated github account" do
        it "returns a hash" do
          expect(complete_profile.github).to be_a(Hash)
        end
      end

      context "a user without an associated github acount" do
        it "returns a string" do
          expect(incomplete_profile.github).to be_nil
        end
      end
    end

    describe "#github_username" do
      context "a user with an associated github account" do
        it "returns a string" do
          expect(complete_profile.github_username).to be_a(String)
        end
      end

      context "a user without an associated github acount" do
        it "returns a string" do
          expect(incomplete_profile.github_username).to be_nil
        end
      end
    end

    describe "#openstreetmap" do
      context "a user with an associated openstreetmap account" do
        it "returns a hash" do
          expect(complete_profile.openstreetmap).to be_a(Hash)
        end
      end

      context "a user without an associated openstreetmap acount" do
        it "returns a string" do
          expect(incomplete_profile.openstreetmap).to be_nil
        end
      end
    end

    describe "#openstreetmap_username" do
      context "a user with an associated openstreetmap account" do
        it "returns a string" do
          expect(complete_profile.openstreetmap_username).to be_a(String)
        end
      end

      context "a user without an associated openstreetmap acount" do
        it "returns a string" do
          expect(incomplete_profile.openstreetmap_username).to be_nil
        end
      end
    end

    describe "#twitter" do
      context "a user with an associated twitter account" do
        it "returns a hash" do
          expect(complete_profile.twitter).to be_a(Hash)
        end
      end

      context "a user without an associated twitter acount" do
        it "returns a string" do
          expect(no_twitter_profile.twitter).to be_nil
        end
      end
    end

    describe "#twitter_username" do
      context "a user with an associated twitter account" do
        it "returns a string" do
          expect(complete_profile.twitter_username).to be_a(String)
        end
      end

      context "a user without an associated twitter acount" do
        it "returns a string" do
          expect(no_twitter_profile.twitter_username).to be_nil
        end
      end
    end

    describe "#venmo" do
      context "a user with an associated venmo account" do
        it "returns a hash" do
          expect(complete_profile.venmo).to be_a(Hash)
        end
      end
    end

    describe "#venmo_username" do
      context "a user with an associated venmo account" do
        it "returns a string" do
          expect(complete_profile.venmo_username).to be_a(String)
        end
      end

      context "a user without an associated venmo acount" do
        it "returns a string" do
          expect(incomplete_profile.openstreetmap_username).to be_nil
        end
      end
    end

    describe "#amount_giving" do
      it "returns a float" do
        expect(complete_profile.amount_giving).to be_a(Float)
      end

      it "returns the same value as its alias: #giving" do
        expect(complete_profile.amount_giving).to eq(complete_profile.giving)
      end
    end

    describe "#amount_receiving" do
      it "returns a float" do
        expect(complete_profile.amount_receiving).to be_a(Float)
      end

      it "returns the same value as its alias: #receiving" do
        expect(complete_profile.amount_receiving)
          .to eq(complete_profile.receiving)
      end
    end

    describe "#goal" do
      context "a user who has defined a goal" do
        it "returns a Float" do
          expect(complete_profile.goal).to be_a(Float)
        end
      end

      context "a user who has not defined a goal" do
        it "returns nil" do
          expect(incomplete_profile.goal).to be_nil
        end
      end
    end

    describe "#number" do
      it "returns a string" do
        expect(complete_profile.number).to be_a(String)
      end

      it "returns the same value as its alias: #account_type" do
        expect(complete_profile.number).to eq(complete_profile.account_type)
      end
    end

    describe "#id" do
      it "returns a fixnum" do
        expect(complete_profile.id).to be_a(Fixnum)
      end
    end

    describe "#npatrons" do
      it "returns a Fixnum" do
        expect(complete_profile.npatrons).to be_a(Fixnum)
      end

      it "returns the same value as its alias: #number_of_patrons" do
        expect(complete_profile.npatrons)
          .to eq(complete_profile.number_of_patrons)
      end
    end

    describe "#on" do
      it "returns a string" do
        expect(complete_profile.on).to be_a(String)
      end
    end

  end # instance methods

end
