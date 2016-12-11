require 'rails_helper'

RSpec.describe Collection, type: :model do
  describe "Associations" do
    it { should belong_to(:user) }
    it { should have_many(:comments) }
    it { should have_many(:resources) }
  end
end
