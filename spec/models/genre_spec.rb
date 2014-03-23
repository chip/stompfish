require 'spec_helper'

describe Genre do
  context "associations" do
    it { should have_many(:albums) }
  end

  context "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end
end
