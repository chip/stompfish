require 'playlist_format/m3u'

describe PlaylistFormat::M3u do
  subject { described_class }

  it "is an m3u text block" do
    song = double(artist_name: "Sample Artist", title: "Sample Title",
                  duration: 123, filename: "/path/to/sample.mp3")
    song_two = double(artist_name: "Second Artist", title: "Second Title",
                  duration: 323, filename: "/path/to/second.mp3")
    songs = [song, song_two]

    sample_m3u = File.read("spec/fixtures/sample.m3u")
    m3u = subject.new(songs)

    expect(m3u.to_playlist).to eq(sample_m3u)
  end
end
