require 'spec_helper'

describe ArtistsController do
  let(:artist) { Artist.create!(name: "Some Artist") }

  describe "GET #index" do
    before { get :index }

    it "assigns Artist.all to @artists" do
      expect(assigns(:artists)).to eq(Artist.all)
    end

    it "renders the :index view" do
      expect(response).to render_template :index
    end

    it "renders @artists as json" do
      Artist.create!(name: "David Bowie")
      serialized = ArtistSerializer.new(Artist.last).serializable_hash
      get :index, format: :json
      expect(response.body).to eq("{\"artists\":[#{serialized.to_json}]}")
    end

    context "with valid search term" do
      it "assigns Artist.search to @artists" do
        expect(Artist).to receive(:search).with("some")
        get :index, query: "some"
      end
    end
  end

  describe "GET #show" do
    before { get :show, id: artist }

    it "assigns the requested artist to @artist" do
      expect(assigns(:artist)).to eq(artist)
    end

    it "renders the :show view" do
      expect(response).to render_template(:show)
    end
  end
end
