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

end
