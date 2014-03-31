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

    it "renders @songs as json" do
      serialized = SongSerializer.new(@song).serializable_hash
      get :index, format: :json
      expect(response.body).to eq("{\"songs\":[#{serialized.to_json}]}")
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
  end
end
