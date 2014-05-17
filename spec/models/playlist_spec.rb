require 'spec_helper'

describe Playlist do
  context "validations" do
    it { should validate_presence_of(:title) }
  end
end
