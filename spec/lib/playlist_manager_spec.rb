require 'playlist_manager'

describe PlaylistManager do
  let(:playlist_collaborator) { Class.new }
  let(:song_one) { double("SongOne", position: 2, duration: 123) }
  let(:song_two) { double("SongTwo", position: 1, duration: 345) }
  let(:song_three) { double("SongThree") }
  let(:songs) { [song_one, song_two] }

  let(:playlist) { double(songs: songs) }

  before { stub_const("PlaylistCollaborator", playlist_collaborator) }

  it "inserts a playlist item at the correct position" do
    expect(playlist.songs).
      to receive(:destroy_all)

    expect(PlaylistCollaborator).
      to receive(:create).
      with(song: song_one, playlist: playlist, position: 0)

    expect(PlaylistCollaborator).
      to receive(:create).
      with(song: song_three, playlist: playlist, position: 1)

    expect(PlaylistCollaborator).
      to receive(:create).
      with(song: song_two, playlist: playlist, position: 2)

    pm = described_class.new(playlist)
    pm.insert(song_three, 1)
  end

  it "appends a playlist item" do
    expect(PlaylistCollaborator).
      to receive(:create).
      with(song: song_three, playlist: playlist, position: 2)

    pm = described_class.new(playlist)
    pm.add(song_three)
  end

  it "returns a playlist runtime" do
    pm = described_class.new(playlist)
    expect(pm.runtime).to eq("07:48")
  end

  it "returns the play order" do
    pm = described_class.new(playlist)

    expect(playlist).
      to receive(:playlist_collaborators).
      and_return(songs)

    expect(pm.play_order).to eq([song_two, song_one])
  end

  it "deletes an item from the playlist" do
    expect(playlist.songs).
      to receive(:destroy_all)

    expect(PlaylistCollaborator).
      to receive(:create).
      with(song: song_two, playlist: playlist, position: 0)

    pm = described_class.new(playlist)
    pm.delete(song_one)
  end
end
