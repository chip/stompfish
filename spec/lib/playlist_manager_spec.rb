require 'playlist_manager'

describe PlaylistManager do
  let(:song_one) { double("SongOne", id: 1, duration: 123) }
  let(:song_two) { double("SongTwo", id: 2, duration: 345) }
  let(:playlist) { double(songs: songs) }
  let(:songs) { [song_one, song_two] }

  context "update playlist.songs" do
    let(:song_ids) { [1, 2] }
    let(:playlist) { double(song_ids: song_ids) }

    it "inserts a playlist item at the correct position" do
      expect(playlist).to receive(:song_ids_will_change!)
      expect(playlist).to receive(:save)

      pm = described_class.new(playlist)
      pm.add(song: 3, position: "1")
      expect(playlist.song_ids).to eq([1, 3, 2])
    end

    it "deletes an item from the playlist" do
      expect(playlist).to receive(:song_ids_will_change!)
      expect(playlist).to receive(:save)

      pm = described_class.new(playlist)
      pm.delete(song: song_one)
      expect(playlist.song_ids).not_to include(1)
    end
  end

  it "returns a playlist runtime" do
    pm = described_class.new(playlist)
    expect(pm.runtime).to eq("07:48")
  end

  context "errors" do
    context "missing position" do
      it "adds error if position is missing" do
        pm = described_class.new(playlist)
        pm.add(song: 3, position: nil)
        expect(pm.errors).to eq({position: "can't be blank"})
      end

      it "adds error if position is blank" do
        pm = described_class.new(playlist)
        pm.add(song: 3, position: "")
        expect(pm.errors).to eq({position: "can't be blank"})
      end
    end

    context "missing song" do
      it "adds error if song does not exist" do
        pm = described_class.new(playlist)
        pm.add(song: nil, position: "1")
        expect(pm.errors).to eq({song: "Resource Not Found."})
      end
    end
  end
end
