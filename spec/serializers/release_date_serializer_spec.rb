require 'spec_helper'

describe ReleaseDateSerializer do
  it "creates customized JSON for an #release_date" do
    release_date = ReleaseDate.new(year: 1977)

    serializer = ReleaseDateSerializer.new(release_date)
    expect(serializer.to_json).to eq('{"release_date":{"year":1977}}')
  end
end
