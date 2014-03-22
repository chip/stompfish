require 'spec_helper'

describe Playlist do
  context "relationships" do
    it { should have_and_belong_to_many(:songs) }
  end

  context "validations" do
    it { should validate_presence_of(:title) }
  end
end
