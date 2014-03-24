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

    it "renders the :index view" do
      get :index
      expect(response).to render_template :index
    end

    it "renders @albums as json" do
      get :index, format: :json
      albums = Album.all
      expect(response.body).to eq(albums.to_json)
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

    it "renders the :show view" do
      expect(response).to render_template(:show)
    end
  end
end
