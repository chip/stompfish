require 'spec_helper'

describe SongsController do
  let(:artist) { Artist.create(name: "Some Artist") }
  let(:album) { Album.create(title: "Some Album", artist: artist) }
  let(:song) { Song.create(title: "Some Song", artist: artist, album: album) }
  let!(:song_file) do
    SongFile.create(fileable_id: song.id, fileable_type: "Song", filename: "filename")
  end
  let!(:serialized) { SongSerializer.new(song).serializable_hash }

  describe "GET #index" do
    before { get :index }

    it "renders @songs as json" do
      get :index, format: :json
      expect(response.body).to eq("{\"songs\":[#{serialized.to_json}]}")
    end

    it "renders all songs if no query" do
      expect(Song).to receive(:all)
      get :index, format: :json
    end

    it "does search if query" do
      expect(SongSearch).to receive(:search).with("search")
      get :index, format: :json, query: "search"
    end
  end

  describe "GET #show" do
    before { get :show, id: song }

    it "has a 200 http status" do
      expect(response.code).to eq("200")
    end

    it "renders @song as json" do
      expect(response.body).to eq("{\"song\":#{serialized.to_json}}")
    end

    context "song not found" do
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
