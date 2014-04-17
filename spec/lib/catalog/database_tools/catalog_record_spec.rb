require 'spec_helper'

describe Catalog::DatabaseTools::CatalogRecord do
  subject { Catalog::DatabaseTools::CatalogRecord }

  let(:filepath) { "spec/fixtures/17 More Than A Mouthful.mp3" }
  let(:tags) { MultimediaTools::Metadata::Read.tags(filepath) }

  it "creates Artist, Genre, Album, Song, SongFile for the import file" do
    subject.new(tags).create
    artist = Artist.last
    album = Album.last
    genre = Genre.last
    release_date = ReleaseDate.last
    song = Song.last
    song_file = SongFile.last

    expect(artist.name).to eq("Nmesh")

    expect(genre.name).to eq("Vaporwave")

    expect(release_date.year).to eq(2013)

    expect(album.title).to eq("Nu.wav Hallucinations")
    expect(album.artist).to eq(artist)
    expect(album.genre).to eq(genre)
    expect(album.release_date).to eq(release_date)

    expect(song.title).to eq("More Than A Mouthful")
    expect(song.artist).to eq(artist)
    expect(song.album).to eq(album)
    expect(song.song_file).to eq(song_file)

    expect(song_file.bit_rate).to eq(319)
    expect(song_file.duration).to eq(46.0)
    expect(song_file.filename).to eq(filepath)
    expect(song_file.filesize).to eq(1856841)
    expect(song_file.format).to eq("mp3")
    expect(song_file.mtime).to eq(File.stat(filepath).mtime)
  end
end
