require 'spec_helper'

module Catalog
  module Import
    describe CreateGenre do
      let(:name) { {genre: "Pop/Rock"} }
      let(:genre_model) { Class.new} 

      before do
        stub_const("GenreModel", genre_model)
      end

      context ".add" do
        it "adds new Genre" do
          expect(genre_model).
            to receive(:find_or_create_by).
            with(name: "Pop/Rock")

          CreateGenre.add(name: "Pop/Rock", genre_model: genre_model)
        end
      end

      context "#name" do
        it "returns nil if no name" do
          genre = CreateGenre.add(name: nil, genre_model: genre_model)
          expect(genre).to be_nil
        end
      end

      context "#genre_model" do
        it "defaults genre model to Genre" do
          creator = CreateGenre.new(name: "foo")
          expect(creator.genre_model).to eq(Genre)
        end
      end
    end
  end
end
