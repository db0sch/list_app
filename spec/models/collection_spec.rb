require 'rails_helper'

RSpec.describe Collection, type: :model do

  subject {
    build(:collection)
  }

  describe "Validations" do
    it 'is valid with valid arguments' do
      expect(subject).to be_valid
    end

    it 'is not valid without a title' do
      subject.title = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid with a too short or too long title (between 5 and 100 chars)' do
      subject.title = "abcd"
      expect(subject).to_not be_valid
      subject.title = "a" * 101
      expect(subject).to_not be_valid
    end

    it 'is not valid without a description or a description too short (less than 5 chars)' do
      subject.description = "xyz"
      expect(subject).to_not be_valid
      subject.description = nil
      expect(subject).to_not be_valid
    end

  end

  describe "Status" do

    subject {
      create(:collection)
    }

    it "is 'public' by default" do
      expect(subject.status == 'is_public').to be true
      expect(subject.is_public?).to be true
    end

    it 'can be "open"' do
      subject.is_open!
      expect(subject.status == 'is_open').to be true
      expect(subject.is_open?).to be true
    end

    it 'can be "public"' do
      subject.is_public!
      expect(subject.status == 'is_public').to be true
      expect(subject.is_public?).to be true
    end

    it 'can be "private"' do
      subject.is_private!
      expect(subject.status == 'is_private').to be true
      expect(subject.is_private?).to be true
    end
  end

  describe "Associations" do
    it { should belong_to(:user) }
    it { should have_many(:comments) }
    it { should have_many(:resources) }
  end

  describe "Act_as_follower/followable" do
    let(:user) { create(:user) }

    subject {
      create(:collection)
    }

    it "can be followed by a user" do
      user.follow(subject)
      follow = user.following?(subject)
      expect(follow).to be true
      followed = subject.followed_by?(user)
      expect(followed).to be true
    end

    it "can be unfollowed by a user" do
      user.follow(subject)
      follow = user.following?(subject)
      expect(follow).to be true
      user.stop_following(subject)
      follow = user.following?(subject)
      expect(follow).to be false
    end
  end

  describe 'act_as_votable' do

    let(:user) { create(:user) }
    subject { create(:collection) }

    it 'can be upvoted by users' do
      user.upvotes subject
      voted = subject.vote_registered?
      expect(voted).to be true
      upvote = user.voted_up_on? subject
      expect(upvote).to be true
    end

    it 'can be unvoted by a user' do
      user.upvotes subject
      voted = subject.vote_registered?
      expect(voted).to be true
      subject.unvote_by user
      upvote = user.voted_up_on? subject
      expect(upvote).to be false
    end
  end

  describe 'scope' do

    before {
      5.times { create(:collection, status: :is_public) }
      2.times { create(:collection, status: :is_open) }
      2.times { create(:collection, status: :is_private) }
    }

    it 'can return only public collection' do
      collections = Collection.is_public
      all_public = collections.all? { |collection| collection.status == "is_public" }
      expect(all_public).to be true
    end

    it 'can return only open collections' do
      collections = Collection.is_open
      all_public = collections.all? { |collection| collection.status == "is_open" }
      expect(all_public).to be true
    end

    it 'can return only private collections' do
      collections = Collection.is_private
      all_public = collections.all? { |collection| collection.status == "is_private" }
      expect(all_public).to be true
    end

    it 'can return open and public collections at the same time' do
      collections = Collection.not_private
      all_public = collections.all? do
        |c| c.status == "is_public" || c.status == "is_open"
      end
      expect(all_public).to be true
    end
  end
end
