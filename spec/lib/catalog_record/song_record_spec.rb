require 'catalog_record/song_record'

describe CatalogRecord::SongRecord do
  subject { CatalogRecord::SongRecord }

  let(:tags) { {title: "Warszawa", track: "8"} }
  let(:song_model) { Class.new} 
  let(:album) { double(artist: "foo") }

  before { stub_const("Song", song_model) }

  it "adds new Song" do
    expect(song_model).
      to receive(:find_or_create_by).
      with(title: "Warszawa", artist: "foo", album: album, track: 8)

    subject.add(tags, album, song_model: song_model)
  end
end
