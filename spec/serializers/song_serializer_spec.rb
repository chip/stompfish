require 'spec_helper'

describe SongSerializer do
  it "creates customized JSON for an #song_file" do
    song = Song.new(title: 'Sound and Vision', track: 1)

    serializer = SongSerializer.new(song)
    expect(serializer.to_json).to eq('{"song":{"id":null,"title":"Sound and Vision","track":1,"artist_id":null,"album_id":null,"song_file":null}}')
  end
end
