require 'spec_helper'

describe PlaylistSongsController do
  let(:artist) { Artist.create(name: "Artist") }
  let(:album) { Album.create(title: "Album", artist: artist) }
  let(:song) { Song.create(title: "Song", artist: artist, album: album) }
  let(:song_two) { Song.create(title: "New Song", artist: artist, album: album) }

  let(:playlist) { Playlist.create(title: "Sample") }
  let(:attributes) { { playlist_id: playlist, id: song, position: 0 } }

  before do
    SongFile.create(filename: "SongFile", fileable_id: song.id, fileable_type: "Song", duration: 234)
    SongFile.create(filename: "SongNewFile", fileable_id: song_two.id, fileable_type: "Song", duration: 234)
  end

  describe "POST #add" do
    context "valid attributes" do
      before { post :create, attributes }

      it "adds a new song to @playlist" do
        playlist.reload
        expect(playlist.song_ids).to include(song.id)
      end

      it "adds multiple songs to @playlist" do
        attrs = { playlist_id: playlist, songs: [song.id, song_two.id] }
        put :update, attrs
        playlist.reload
        expect(playlist.song_ids).to include(song.id, song_two.id)
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
  end
end
