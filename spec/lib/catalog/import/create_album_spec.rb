require 'spec_helper'

module Catalog
  module Import
    describe CreateAlbum do
      let(:genre) { double("genre") }
      let(:artist) { double("artist") }
      let(:date) { double("date") }

      let(:album_model) { Class.new }
      let(:album_instance) { double(:update) }

      context ".add" do
        before do
          stub_const("AlbumModel", album_model)
        end

        it "adds new Album" do
          expect(album_model).
            to receive(:find_or_create_by).
            with(title: "Low", artist: artist).
            and_return album_instance

          expect(album_instance).
            to receive(:update).
            with(date: date, genre: genre)

          CreateAlbum.add(title: "Low", artist: artist, genre: genre,
                          date: date, album_model: album_model)
        end

        it "returns an Album" do
          expect(album_model).
            to receive(:find_or_create_by).
            and_return(album_instance)

          expect(album_instance).
            to receive(:update)

          album = CreateAlbum.add(title: "Low", artist: artist, genre: genre,
                                  date: date, album_model: album_model)

          expect(album).to eq(album_instance)
        end
      end

      context "#album_model" do
        it "defaults to Album" do
          album = CreateAlbum.new(title: "", artist: "", date: "", genre: "", date: "")
          expect(album.album_model).to eq(Album)
        end
      end
    end
  end
end
