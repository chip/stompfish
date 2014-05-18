require 'spec_helper'

describe PlaylistsController do
  let(:playlist) { Playlist.create(title: "Sample") }
  let(:serialized) { PlaylistSerializer.new(playlist).serializable_hash }

  describe "GET #index" do
    it "renders @playlists as json" do
      serialized
      get :index
      expect(response.body).to eq("{\"playlists\":[#{serialized.to_json}]}")
    end

    it "has a 200 status code" do
      get :index
      expect(response.code).to eq("200")
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
      get :show, id: playlist
      expect(response.body).to eq("{\"playlist\":#{serialized.to_json}}")
    end

    context "playlist not found" do
      it "has a 404 status" do
        get :show, id: :foo
        expect(response.code).to eq("404")
      end

      it "has a playlist" do
        get :show, id: :foo
        expect(response.body).to eq("{\"message\":\"Resource Not Found.\"}")
      end
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      let(:attributes) { { title: "Sample" } }

      it "saves the playlist" do
        expect do
          post :create, attributes
        end.to change(Playlist, :count).by(1)
      end

      it "has a 201 status" do
        post :create, attributes
        expect(response.code).to eq("201")
      end

      it "renders playlist as json" do
        post :create, attributes
        created = PlaylistSerializer.new(Playlist.last)
        expect(response.body).to eq(created.to_json)
      end
    end

    context "with invalid attributes" do
      let(:invalid) { {} }

      it "does not save the playlist" do
        expect do
          post :create, invalid
        end.not_to change(Playlist, :count)
      end

      it "has a 422 status" do
        post :create, invalid
        expect(response.code).to eq("422")
      end

      it "returns the error" do
        post :create, invalid
        expect(response.body).to eq("{\"title\":[\"can't be blank\"]}")
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

      it "has a 201 status" do
        expect(response.code).to eq("201")
      end

      it "renders playlist as json" do
        playlist.reload
        updated = PlaylistSerializer.new(playlist)
        expect(response.body).to eq(updated.to_json)
      end
    end

    context "with invalid attributes" do
      before { patch :update, id: playlist, title: nil }

      it "does not change the playlist's attributes" do
        playlist.reload
        expect(playlist.title).not_to eq(nil)
      end

      it "has a 422 status" do
        expect(response.code).to eq("422")
      end

      it "returns the error" do
        expect(response.body).to eq("{\"title\":[\"can't be blank\"]}")
      end
    end

    context "playlist not found" do
      before { patch :update, id: :foo, title: nil }

      it "has a 404 status" do
        expect(response.code).to eq("404")
      end

      it "returns the error" do
        expect(response.body).to eq("{\"message\":\"Resource Not Found.\"}")
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:playlist) { Playlist.create(title: "Sample Playlist") }
    
    context "success" do
      it "returns a 200" do
        delete :destroy, id: playlist
        expect(response.code).to eq("200")
      end

      it "has a success message" do
        delete :destroy, id: playlist
        expect(response.body).to eq("{\"message\":\"Playlist destroyed!\"}")
      end

      it "destroys playlist" do
        expect do
          delete :destroy, id: playlist
        end.to change(Playlist, :count).by(-1)
      end
    end

    context "playlist not found" do
      before { delete :destroy, id: :foo }

      it "has a 404 status" do
        expect(response.code).to eq("404")
      end

      it "returns the error" do
        expect(response.body).to eq("{\"message\":\"Resource Not Found.\"}")
      end
    end
  end
end
