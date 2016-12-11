require 'rails_helper'

RSpec.describe Resource, type: :model do
  describe "Associations" do
    it { should belong_to(:collection) }
    it { should have_many(:comments) }
  end
end
