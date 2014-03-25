require 'spec_helper'

describe ArtistSerializer do
  it "creates customized JSON for an #artist" do
    artist = Artist.new(name: "David Bowie")

    serializer = ArtistSerializer.new(artist)
    expect(serializer.to_json).
      to eq('{"artist":{"id":null,"name":"David Bowie","albums":[]}}')
  end
end
