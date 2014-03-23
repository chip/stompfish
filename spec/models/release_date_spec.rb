require 'spec_helper'

describe ReleaseDate do
  context "associations" do
    it { should have_many(:albums) }
  end

  context "validations" do
    it { should validate_presence_of(:year) }
    it { should validate_uniqueness_of(:year) }
  end
end
