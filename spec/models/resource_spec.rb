require 'rails_helper'

RSpec.describe Resource, type: :model do
  let(:collection) { build(:collection) }

  subject {
    build(:resource)
  }

  describe "Validations" do
    it 'is valid with valid arguments' do
      expect(subject).to be_valid
    end

    it 'is not valid if the collection is not valid either' do
      collection.title = "abc"
      subject.collection = collection
      expect(subject).to_not be_valid
    end

    it 'is not valid without a title' do
      subject.title = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid with a title too short (< 0 chars) or too long (> 100 chars)' do
      subject.title = ""
      expect(subject).to_not be_valid
      subject.title = "a" * 101
      expect(subject).to_not be_valid
    end
  end

  describe "Associations" do
    it { should belong_to(:collection) }
    it { should have_many(:comments) }
  end

  describe 'act_as_votable' do

    let(:user) { create(:user) }
    subject { create(:resource) }

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
end
