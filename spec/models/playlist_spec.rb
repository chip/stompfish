require 'spec_helper'

describe Playlist do
  context "validations" do
    it { should validate_presence_of(:title) }

    it "validates numericality of song_ids values" do
      playlist = Playlist.new(title: "foo", song_ids: %w(foo))
      playlist.save
      expect(playlist.errors.messages). to eq({song_ids: ["must be integer values"]})
    end
  end
end
