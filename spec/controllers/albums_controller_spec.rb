require 'spec_helper'

describe AlbumsController do
  let(:artist) { Artist.create(name: "Some Artist") }
  let(:album) { Album.create(title: "Some Album", artist: artist) }
  let!(:serialized) { AlbumSerializer.new(album).serializable_hash }

  describe "GET #index" do
    it "renders @albums as json" do
      get :index
      serialized = AlbumSerializer.new(album).serializable_hash
      expect(response.body).to eq("{\"albums\":[#{serialized.to_json}]}")
    end

    context "with search term" do
      it "assigns Album.search.results to @albums" do
        expect(Album).to receive(:search).with("foo")
        get :index, query: "foo"
      end
    end
  end

  describe "GET #show" do
    before { get :show, id: album }

    it "has a 200 http status" do
      expect(response.code).to eq("200")
    end

    it "renders @album as json" do
      expect(response.body).to eq("{\"album\":#{serialized.to_json}}")
    end

    context "album not found" do
      it "has a 404 status" do
        get :show, id: :foo
        expect(response.code).to eq("404")
      end

      it "has a message" do
        get :show, id: :foo
        expect(response.body).to eq("{\"message\":\"Resource Not Found.\"}")
      end
    end
  end
end
