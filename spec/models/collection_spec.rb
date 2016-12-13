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
end
