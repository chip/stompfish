require 'spec_helper'

describe PlaylistsController do
  let(:playlist) { Playlist.create(title: "Sample") }
  let(:artist) { Artist.create(name: "Artist") }
  let(:album) { Album.create(title: "Album", artist: artist) }
  let(:song) { Song.create(title: "Song", artist: artist, album: album) }

  describe "GET #index" do
    it "assigns Playlist.all to @playlists" do
      get :index
      expect(assigns(:playlists)).to eq(Playlist.all)
    end

    it "renders @playlists as json" do
      serialized = PlaylistSerializer.new(playlist).serializable_hash
      get :index, format: :json
      expect(response.body).to eq("{\"playlists\":[#{serialized.to_json}]}")
    end

    context "with valid search term" do
      it "assigns Playlist.search to @playlists" do
        expect(Playlist).to receive(:search).with("some")
        get :index, query: "some"
      end
    end
  end

  describe "GET #show" do
    it "renders playlist as json" do
      serialized = PlaylistSerializer.new(playlist).serializable_hash
      get :show, id: playlist, format: :json
      expect(response.body).to eq("{\"playlist\":#{serialized.to_json}}")
    end
  end

  describe "GET #new" do
    before { get :new }

    it "assigns a new Playlist to @playlist" do
      expect(assigns(:playlist)).to be_a_new(Playlist)
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      let(:attributes) { { title: "New Playlist" } }

      it "saves the playlist" do
        expect do
          post :create, attributes
        end.to change(Playlist, :count).by(1)
      end
    end

    context "with invalid attributes" do
      let(:invalid) { {} }

      it "does not save the playlist" do
        expect do
          post :create, invalid
        end.not_to change(Playlist, :count)
      end
    end
  end

  describe "PATCH #update" do
    let!(:playlist) { Playlist.create!(title: "Another Playlist") }

    context "with valid attributes" do
      before { patch :update, id: playlist, title: "Something Else" }

      it "changes the playlist's attributes" do
        playlist.reload
        expect(playlist.title).to eq("Something Else")
      end
    end
  end

  describe "DELETE #destroy" do
  end

  describe "POST #add" do
    it "adds a new song to @playlist" do
      post :add, id: playlist, song: song, position: 1
      playlist.reload
      expect(playlist.songs).to include(song)
    end
  end

  describe "DELETE #delete_item" do
    it "deletes an item from @playlist" do
      post :add, id: playlist, song: song, position: 1
      playlist.reload
      delete :delete_item, id: playlist, song: song
      playlist.reload
      expect(playlist.songs).not_to include(song)
    end
  end
end
