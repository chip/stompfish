require 'spec_helper'

describe SongFile do
  it { should belong_to(:fileable) }

  it { should validate_presence_of(:filename) }
  it { should validate_presence_of(:fileable_id) }
  it { should validate_presence_of(:fileable_type) }
  it { should validate_uniqueness_of(:filename) }

  it "has a human readable duration" do
    song_file = SongFile.new(duration: 201.345)
    expect(song_file.duration_to_human).to eq "03:21"
  end
end
