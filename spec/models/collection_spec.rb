require 'rails_helper'

RSpec.describe Collection, type: :model do
  describe "Associations" do
    it { should belong_to(:user) }
  end
end
