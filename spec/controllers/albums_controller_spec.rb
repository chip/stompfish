require 'spec_helper'

describe AlbumsController do
  before do
    artist = Artist.create!(name: "Some Artist")
    @album = Album.create!(title: "Some Album", artist: artist)
  end

  describe "GET #index" do

    it "assigns Album.all to @albums" do
      get :index
      expect(assigns(:albums)).to eq(Album.all)
    end

    it "renders @albums as json" do
      get :index, format: :json
      serialized = AlbumSerializer.new(@album).serializable_hash
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
    before { get :show, id: @album }

    it "assigns the requested album to @album" do
      expect(assigns(:album)).to eq(@album)
    end
  end
end
