require 'spec_helper'

describe Artist do
  context "associations" do
    it { should have_many(:albums) }
    it { should have_many(:songs) }
  end

  context "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end
end
