require 'spec_helper'

describe PlaylistsController do
  let(:playlist) { Playlist.create(title: "Sample") }

  describe "GET #index" do
    before { get :index }

    it "assigns Playlist.all to @playlists" do
      expect(assigns(:playlists)).to eq(Playlist.all)
    end

    it "renders the :index view" do
      expect(response).to render_template :index
    end
  end

  describe "GET #show" do
    before { get:show, id: playlist}

    it "assigns the requested playlist to @playlist" do
      expect(assigns(:playlist)).to eq(playlist)
    end

    it "renders the :show view" do
      expect(response).to render_template(:show)
    end
  end

  describe "GET #new" do
    before { get :new }

    it "assigns a new Playlist to @playlist" do
      expect(assigns(:playlist)).to be_a_new(Playlist)
    end

    it "renders the :new view" do
      expect(response).to render_template(:new)
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

      it "redirects to playlists#show" do
        post :create, attributes
        expect(response).to redirect_to(playlist_path(assigns(:playlist)))
      end
    end

    context "with invalid attributes" do
      let(:invalid) { {} }

      it "does not save the playlist" do
        expect do
          post :create, invalid
        end.not_to change(Playlist, :count)
      end

      it "re-renders the :new view" do
        post :create, invalid
        expect(response).to render_template(:new)
      end
    end
  end

  describe "GET #edit" do
    before { get :edit, id: playlist }

    it "assigns the requested playlist to @playlist" do
      expect(assigns(:playlist)).to eq(playlist)
    end

    it "renders the :edit view" do
      expect(response).to render_template(:edit)
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

      it "redirects to playlist's :show view" do
        expect(response).to redirect_to(playlist)
      end
    end

    context "with invalid attributes" do
      before { patch :update, id: playlist, title: nil }

      it "does not change the playlist's attributes" do
        playlist.reload
        expect(playlist.title).to eq("Another Playlist")
      end

      it "renders the :edit view" do
        expect(response).to render_template :edit
      end
    end
  end
end
