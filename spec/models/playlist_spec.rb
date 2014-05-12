require 'spec_helper'

describe Playlist do
  context "associations" do
    it { should have_many(:songs).through(:playlist_collaborators) }
  end

  context "validations" do
    it { should validate_presence_of(:title) }
  end
end
