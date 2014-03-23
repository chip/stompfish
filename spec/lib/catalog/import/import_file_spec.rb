require 'spec_helper'

module Catalog
  module Import
    describe ImportFile do
      let(:filepath) { "spec/fixtures/17 More Than A Mouthful.mp3" }

      context "#add" do
        it "creates Artist, Genre, Album, Song, SongFile for the import file" do
          ImportFile.new(filepath).add
          artist = Artist.last
          album = Album.last
          genre = Genre.last
          song = Song.last
          song_file = SongFile.last

          expect(artist.name).to eq("Nmesh")

          expect(genre.name).to eq("Vaporwave")

          expect(album.title).to eq("Nu.wav Hallucinations")
          expect(album.artist).to eq(artist)
          expect(album.genre).to eq(genre)

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
      end

      context "#filepath" do
        it "returns filepath" do
          import_file = ImportFile.new(filepath).filepath
          expect(import_file).to eq(filepath)
        end

        it "raises error if file does not exist" do
          expect do
            ImportFile.add("foo")
          end.to raise_error(FileNotFound)
        end
      end
    end
  end
end
