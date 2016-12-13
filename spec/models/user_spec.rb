require 'rails_helper'

RSpec.describe User, type: :model do
  subject {
    build(:user)
  }

  describe "Validations" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without a name" do
      subject.name = nil
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

  describe "Associations" do
    it { should have_many(:collections) }
    it { should have_many(:comments) }
    it { should have_many(:resources) }
    it { should have_many(:follows) }
  end

  describe "Act_as_followable/followeer" do
    let(:collection) { create(:collection) }
    let(:interesting_user) { create(:user) }
    let(:interested_user) { create(:user) }

    subject {
      create(:user)
    }

    it 'can be followed by other user' do
      subject.save
      interesting_user.save
      interested_user.follow(subject)
      follow = interested_user.following?(subject)
      expect(follow).to be true
      followed = subject.followed_by?(interested_user)
      expect(followed).to be true
    end

    it 'can follow other users' do
      subject.follow(interesting_user)
      follow = subject.following?(interesting_user)
      expect(follow).to be true
      followed = interesting_user.followed_by?(subject)
      expect(followed).to be true
    end

    it 'can follow collections' do
      subject.follow(collection)
      follow = subject.following?(collection)
      expect(follow).to be true
      followed = collection.followed_by?(subject)
      expect(followed).to be true
    end
  end

end
