require 'rails_helper'

RSpec.describe User, type: :model do
  subject {
    build(:user)
  }

  describe "Validations" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without a username" do
      subject.username = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without a first_name' do
      subject.first_name = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without a last_name' do
      subject.last_name = nil
      expect(subject).to_not be_valid
    end

    it "is not valid with a password < 6 chars or without any password" do
      subject.password = nil
      expect(subject).to_not be_valid
      subject.password = "pass"
      expect(subject).to_not be_valid
    end

    it "is not valid without an email" do
      subject.email = nil
      expect(subject).to_not be_valid
    end

    it "is valid with or without a bio" do
      expect(subject).to be_valid
      subject.bio = nil
      expect(subject).to be_valid
    end
  end

  describe "Admin" do
    it 'is not admin by default' do
      subject.save
      expect(subject.admin).to be false
    end
  end

  describe "Associations" do
    it { should have_many(:collections) }
    it { should have_many(:comments) }
    it { should have_many(:resources) }
    it { should have_many(:follows) }
  end

  describe "Act_as_followable/follower" do
    let(:collection) { create(:collection) }
    let(:interesting_user) { create(:user) }
    let(:interested_user) { create(:user) }

    subject {
      create(:user)
    }

    it 'can be followed by other user' do
      interested_user.follow(subject)
      follow = interested_user.following?(subject)
      expect(follow).to be true
      followed = subject.followed_by?(interested_user)
      expect(followed).to be true
    end

    it 'can be unfollowed by a user' do
      interested_user.follow(subject)
      follow = interested_user.following?(subject)
      expect(follow).to be true
      interested_user.stop_following(subject)
      follow = interested_user.following?(subject)
      expect(follow).to be false
    end

    it 'can follow other users' do
      subject.follow(interesting_user)
      follow = subject.following?(interesting_user)
      expect(follow).to be true
      followed = interesting_user.followed_by?(subject)
      expect(followed).to be true
    end

    it 'can unfollow a user' do
      subject.follow(interesting_user)
      follow = subject.following?(interesting_user)
      expect(follow).to be true
      subject.stop_following(interesting_user)
      follow = subject.following?(interesting_user)
      expect(follow).to be false
    end

    it 'can follow collections' do
      subject.follow(collection)
      follow = subject.following?(collection)
      expect(follow).to be true
      followed = collection.followed_by?(subject)
      expect(followed).to be true
    end

    it 'can unfollow a collection' do
      subject.follow(collection)
      follow = subject.following?(collection)
      expect(follow).to be true
      subject.stop_following(collection)
      follow = subject.following?(collection)
      expect(follow).to be false
    end
  end

  describe 'act as voter' do
    let(:collection) { create(:collection) }
    let(:resource) { create(:resource) }

    subject {
      create(:user)
    }

    it 'can upvote a collection' do
      subject.upvotes collection
      voted = collection.vote_registered?
      expect(voted).to be true
      upvote = subject.voted_up_on? collection
      expect(upvote).to be true
    end

    it 'can unvote a collection' do
      subject.upvotes collection
      voted = collection.vote_registered?
      expect(voted).to be true
      collection.unvote_by subject
      upvote = subject.voted_up_on? collection
      expect(upvote).to be false
    end

    it 'can upvote a resource' do
      subject.upvotes resource
      voted = resource.vote_registered?
      expect(voted).to be true
      upvote = subject.voted_up_on? resource
      expect(upvote).to be true
    end

    it 'can unvote a resource' do
      subject.upvotes resource
      voted = resource.vote_registered?
      expect(voted).to be true
      resource.unvote_by subject
      upvote = subject.voted_up_on? resource
      expect(upvote).to be false
    end
  end

  describe "#full_name" do
    it 'should return the full name concatenated' do
      fullname = "#{subject.first_name} #{subject.last_name}"
      expect(subject.full_name == fullname).to be true
    end
  end

end
