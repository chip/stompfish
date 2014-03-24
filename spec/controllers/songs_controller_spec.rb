require 'spec_helper'

describe SongsController do
  before do
    artist = Artist.create!(name: "Some Artist")
    album = Album.create!(title: "Some Album", artist: artist)
    @song = Song.create!(title: "Some Song", artist: artist, album: album)
  end

  describe "GET #index" do
    before { get :index }

    it "assigns Song.all to @song" do
      expect(assigns(:songs)).to eq(Song.all)
    end

    it "renders the :index view" do
      expect(response).to render_template :index
    end

    it "renders @songs as json" do
      get :index, format: :json
      songs = Song.all
      expect(response.body).to eq(songs.to_json)
    end

    context "with valid search term" do
      it "assigns Song.search to @songs" do
        expect(Song).to receive(:search).with("some")
        get :index, query: "some"
      end
    end
  end

  describe "GET #show" do
    before { get :show, id: @song }

    it "assigns the requested song to @song" do
      expect(assigns(:song)).to eq(@song)
    end

    it "renders the :show view" do
      expect(response).to render_template(:show)
    end
  end
end
