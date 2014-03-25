require 'spec_helper'

describe GenreSerializer do
  it "creates customized JSON for an #genre" do
    genre = Genre.new(name: "Pop/Rock")

    serializer = GenreSerializer.new(genre)
    expect(serializer.to_json).to eq('{"genre":{"name":"Pop/Rock"}}')
  end
end
