require 'spec_helper'

module Catalog
  module Import
    describe CreateArtist do
      let(:name) { "David Bowie" }
      let(:artist_model) { Class.new} 

      context ".add" do
        it "adds new Artist" do
          stub_const("ArtistModel", artist_model)

          expect(artist_model).
            to receive(:find_or_create_by).
            with(name: "David Bowie")

          CreateArtist.add(name: "David Bowie", artist_model: artist_model)
        end
      end

      context "#artist_model" do
        it "defaults artist model to Artist" do
          creator = CreateArtist.new(name: "David Bowie")
          expect(creator.artist_model).to eq(Artist)
        end
      end
    end
  end
end
