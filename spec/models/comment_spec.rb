require 'rails_helper'

RSpec.describe Comment, type: :model do

  subject {
    build(:comment)
  }

  describe "Validation" do
    it "is valid with valid arguments" do
      expect(subject).to be_valid
    end

    it 'is not valid without a user' do
      subject.user = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without a content' do
      subject.content = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid with a content too short (< 5 chars)' do
      subject.content = "abcd"
      expect(subject).to_not be_valid
    end
  end

  describe "Associations" do
    it { should belong_to(:commentable) }
    it { should belong_to(:user) }
  end

end
