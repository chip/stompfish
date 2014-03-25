require 'spec_helper'

describe SongFileSerializer do
  it "creates customized JSON for an #song_file" do
    song_file = SongFile.new(filename: "foo.flac", filesize: 123, bit_rate: 234,
                             format: "flac", duration: 345.12,
                             mtime: "Wed, 18 Sep 2013 22:28:57 UTC +00:00")

    serializer = SongFileSerializer.new(song_file)
    expect(serializer.to_json).to eq('{"song_file":{"id":null,"bit_rate":234,"duration":345.12,"filename":"foo.flac","filesize":123,"format":"flac","mtime":"2013-09-18T22:28:57.000Z"}}')
  end
end
