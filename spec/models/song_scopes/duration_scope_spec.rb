require 'spec_helper'

module SongScopes
  describe DurationScope do
    let!(:song) { Song.create!(title: "Foo", artist_id: 1, album_id: 1) }
    let!(:song_file) { SongFile.create!(filename: "foo", duration: 123,
                                       fileable_id: song.id, fileable_type: "Song") }

    context "#less_than" do
      it "has song files with durations less than x" do
        files = DurationScope.new(high: "2:04").less_than
        expect(files).to eq([song])
      end
    end

    context "#greater_than" do
      it "has song files with durations greater than x" do
        files = DurationScope.new(low: "2:02").greater_than
        expect(files).to eq([song])
      end
    end

    context "#between" do
      it "has song files with durations between x & y" do
        files = DurationScope.new(low: "2:02", high: "2:04").between
        expect(files).to eq([song])
      end
    end
  end
end
