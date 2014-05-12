require 'playlist_manager'

describe PlaylistManager do
  let(:song_one) { double(position: 2, duration: 123) }
  let(:song_two) { double(position: 1, duration: 345) }
  let(:song_three) { double("new_song") }
  let(:songs) { [song_one, song_two] }

  let(:playlist) { double(songs: songs) }

  it "inserts a playlist item at the correct position" do
    pm = PlaylistManager.new(playlist)
    pm.insert_track_at(song_three, 1)
    expect(pm.playlist.songs).to match_array([song_one, song_three, song_two])
  end

  it "appends a playlist item" do
    pm = PlaylistManager.new(playlist)
    pm.add(song_three)
    expect(pm.playlist.songs).to match_array([song_one, song_two, song_three])
  end

  it "returns a playlist runtime" do
    pm = PlaylistManager.new(playlist)
    expect(pm.runtime).to eq("07:48")
  end

  it "returns the play order" do
    pm = PlaylistManager.new(playlist)
    expect(pm.play_order).to match_array([song_two, song_one])
  end
end
