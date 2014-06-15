require 'quick_playlist'

describe QuickPlaylist do
  subject { described_class }

  it "auto creates a playlist from a search" do
    sorted = [double(track: 1), double(track: 2), double(track: 3)]
    playlist = Class.new
    playlist_manager = double("playlist_manager")

    stub_const("Playlist", playlist)

    expect(Playlist).
      to receive(:create).
      with(title: "Some Search").
      and_return(playlist)

    expect(PlaylistManager).
      to receive(:new).
      with(playlist).
      and_return(playlist_manager)

    expect(SongSearch).
      to receive(:search).
      with("Some Search").
      and_return(sorted)

    expect(playlist_manager).to receive(:add).with(sorted)

    qp = subject.new("Some Search").save
    
    expect(qp).to eq(playlist)
  end
end
