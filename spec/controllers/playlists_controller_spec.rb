require 'spec_helper'

describe PlaylistsController do
  let(:playlist) { Playlist.create(title: "Sample") }

  describe "GET #index" do
    before { get :index }

    it "assigns Playlist.all to @playlists" do
      expect(assigns(:playlists)).to eq(Playlist.all)
    end
  end

  describe "GET #show" do
    before { get :show, id: playlist }

    it "assigns the requested playlist to @playlist" do
      expect(assigns(:playlist)).to eq(playlist)
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

  describe "GET #edit" do
    before { get :edit, id: playlist }

    it "assigns the requested playlist to @playlist" do
      expect(assigns(:playlist)).to eq(playlist)
    end
  end

  describe "PATCH #update" do
    let!(:playlist) { Playlist.create!(title: "Another Playlist") }

    context "with valid attributes" do
      before { patch :update, id: playlist, title: "Something Else" }

      it "locates the correct playlist" do
        expect(assigns(:playlist)).to eq(playlist)
      end

      it "changes the playlist's attributes" do
        playlist.reload
        expect(playlist.title).to eq("Something Else")
      end
    end
  end
end
