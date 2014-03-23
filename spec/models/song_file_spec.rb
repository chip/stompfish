require 'spec_helper'

describe SongFile do
  context "associations" do
    it { should belong_to(:fileable) }
  end

  context "validations" do
    it { should validate_presence_of(:filename) }
    it { should validate_presence_of(:fileable_id) }
    it { should validate_presence_of(:fileable_type) }
    it { should validate_uniqueness_of(:filename) }
  end

  context "#duration_to_human" do
    it "has a human readable duration" do
      song_file = SongFile.new(duration: 201.345)
      expect(song_file.duration_to_human).to eq "03:21"
    end
  end

  context "#filesize_to_human" do
    it "has a human readable filesize" do
      song_file = SongFile.new(filesize: 123456)
      expect(song_file.filesize_to_human).to eq "121 KB"
    end
  end
end
