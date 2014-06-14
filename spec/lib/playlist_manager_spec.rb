require 'playlist_manager'

describe PlaylistManager do
  let(:song_one) { double("SongOne", id: 1, duration: 123) }
  let(:song_two) { double("SongTwo", id: 2, duration: 345) }
  let(:playlist) { double(songs: songs) }
  let(:songs) { [song_one, song_two] }

  context "update playlist.songs" do
    let(:playlist) { double(song_ids: [1,2]) }
    let(:song_three) { double(id: 3) }

    context "#add" do
      it "inserts a playlist item at the correct position" do
        expect(playlist).to receive(:song_ids_will_change!)
        expect(playlist).to receive(:save)

        pm = described_class.new(playlist)
        pm.add(song_three, position: "1")
        expect(playlist.song_ids).to eq([1, 3, 2])
      end

      it "removes nils during insert" do
        expect(playlist).to receive(:song_ids_will_change!)
        expect(playlist).to receive(:save)

        pm = described_class.new(playlist)
        pm.add(song_three, position: "5")
        expect(playlist.song_ids).to eq([1, 2, 3])
      end

      it "accepts integer for position" do
        expect(playlist).to receive(:song_ids_will_change!)
        expect(playlist).to receive(:save)

        pm = described_class.new(playlist)
        pm.add(song_three, position: 1)
        expect(playlist.song_ids).to eq([1, 3, 2])
      end

      it "adds multiple songs" do
        song_three = double(id: 3)
        song_four = double(id: 4)
        expect(playlist).to receive(:song_ids_will_change!)
        expect(playlist).to receive(:save)

        pm = described_class.new(playlist)
        pm.add([song_three, song_four])
        expect(playlist.song_ids).to eq([1, 2, 3, 4])
      end
    end

    context "#delete" do
      it "deletes an item from the playlist" do
        expect(playlist).to receive(:song_ids_will_change!)
        expect(playlist).to receive(:save)

        pm = described_class.new(playlist)
        pm.delete(song_one)
        expect(playlist.song_ids).not_to include(1)
      end
    end
  end

  context "#runtime" do
    it "returns 00:00 if no songs" do
      playlist = double(songs: [])
      pm = PlaylistManager.new(playlist)
      expect(pm.runtime).to eq("00:00")
    end

    it "returns a playlist runtime" do
      pm = described_class.new(playlist)
      expect(pm.runtime).to eq("07:48")
    end
  end
end
