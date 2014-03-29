require 'spec_helper'

describe Catalog::Importors::SingleFile do
  subject { Catalog::Importors::SingleFile }

  let(:filepath) { "spec/fixtures/17 More Than A Mouthful.mp3" }

  context "#add" do
    it "creates Artist, Genre, Album, Song, SongFile for the import file" do
      subject.new(filepath: filepath).add
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

      expect(song_file.bit_rate).to eq(320009)
      expect(song_file.duration).to eq(46.419592)
      expect(song_file.filename).to eq(filepath)
      expect(song_file.filesize).to eq(1856841)
      expect(song_file.format).to eq("mp3")
      expect(song_file.mtime).to eq("2014-03-18 02:24:57.834328000 +0000")
    end

    it "logs errors for exceptions" do
      fixed = double("safe_encoded_filename")
      import_log = Class.new
      stub_const("ImportLog", import_log)

      expect(MultimediaTools::Metadata::Read).
        to receive(:tags).
        and_return({filename: "foobar"})

      expect(Catalog::DatabaseTools::AlbumRecord).
        to receive(:add).
        and_raise(Exception)

      expect(import_log).
        to receive(:create!).
        with(stacktrace: "Exception",
             filename: "foobar")

      subject.new(filepath: "spec/fixtures/17 More Than A Mouthful.mp3").add
    end

    it "optionally takes @tags upon initialize" do
      single = subject.new(tags: {artist: "artist"})
      expect(single.tags).to eq({artist: "artist"})
    end
  end

  context "#filepath" do
    it "returns filepath" do
      import_file = subject.new(filepath: filepath).filepath
      expect(import_file).to eq(filepath)
    end

    it "raises error if file does not exist" do
      expect do
        subject.new(filepath: "foo").add
      end.to raise_error(Catalog::Importors::FileNotFound)
    end
  end
end
