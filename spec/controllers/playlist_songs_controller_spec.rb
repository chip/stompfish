require 'spec_helper'

describe PlaylistSongsController do
  let(:artist) { Artist.create(name: "Artist") }
  let(:album) { Album.create(title: "Album", artist: artist) }
  let(:song) { Song.create(title: "Song", artist: artist, album: album) }

  let(:playlist) { Playlist.create(title: "Sample") }
  let(:attributes) { { playlist_id: playlist, id: song, position: 0 } }

  describe "POST #add" do
    context "valid attributes" do
      before { post :create, attributes }

      it "adds a new song to @playlist" do
        playlist.reload
        expect(playlist.song_ids).to include(song.id)
      end

      it "has a 201 status" do
        expect(response.code).to eq("201")
      end

      it "returns the playlist" do
        playlist.reload
        updated = PlaylistSerializer.new(playlist)
        expect(response.body).to eq(updated.to_json)
      end
    end

    context "invalid attributes" do
      let(:invalid) { { playlist_id: playlist, id: song, position: nil } }
      before { post :create, invalid }

      it "has a 422 status" do
        expect(response.code).to eq("422")
      end

      it "returns the error" do
        expect(response.body).to eq("{\"position\":\"can't be blank\"}")
      end
    end

    context "playlist not found" do
      let(:invalid) { { playlist_id: "", id: song, position: 0 } }
      before { post :create, invalid }

      it "has a 404 status" do
        expect(response.code).to eq("404")
      end

      it "returns the error" do
        expect(response.body).to eq("{\"message\":\"Resource Not Found.\"}")
      end
    end
  end

  describe "DELETE #delete_item" do
    context "success" do
      it "deletes an item from @playlist" do
        post :create, attributes
        delete :destroy, playlist_id: playlist, id: song
        playlist.reload
        expect(playlist.song_ids).not_to include(song.id)
      end

      it "returns the playlist" do
        post :create, attributes
        delete :destroy, playlist_id: playlist, id: song
        playlist.reload
        deleted = PlaylistSerializer.new(playlist)
        expect(response.body).to eq(deleted.to_json)
      end
    end

    context "song not found" do
      it "has a 404 status" do
        delete :destroy, playlist_id: playlist, id: :foo
        expect(response.code).to eq("404")
      end

      it "returns the error" do
        delete :destroy, playlist_id: playlist, id: :foo
        expect(response.body).to eq("{\"song\":\"Resource Not Found.\"}")
      end
    end

    context "playlist not found" do
      before { delete :destroy, playlist_id: :foo, id: :foo }

      it "has a 404 status" do
        expect(response.code).to eq("404")
      end

      it "returns the error" do
        expect(response.body).to eq("{\"message\":\"Resource Not Found.\"}")
      end
    end
  end
end
