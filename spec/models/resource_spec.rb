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

    it 'is not valid with a title too short (< 5 chars) or too long (> 100 chars)' do
      subject.title = "abcd"
      expect(subject).to_not be_valid
      subject.title = "a" * 101
      expect(subject).to_not be_valid
    end
  end

  describe "Associations" do
    it { should belong_to(:collection) }
    it { should have_many(:comments) }
  end
end
