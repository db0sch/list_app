require 'rails_helper'

RSpec.describe User, type: :model do

  subject {
    user = build(:user)
  }

  describe "Associations" do
    it { should have_many(:collections) }
    it { should have_many(:comments) }
    it { should have_many(:resources) }
    it { should have_many(:follows) }
  end

end
