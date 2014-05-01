require 'services/lastfm/uri'

describe Services::Lastfm::Uri do
  subject { described_class }

  let(:uri) { URI("http://ws.audioscrobbler.com/2.0/?method=signature&api_key=123&format=json") }

  it "builds a lastfm api uri for 'signature'" do
    built = subject.new("signature", api_key: 123).build
    expect(built).to eq(uri)
  end

  it "parses response for a lastfm api call" do
    response = double("lastfm_response")

    expect(Net::HTTP).
      to receive(:get).
      with(uri).
      and_return(response)

    expect(JSON).
      to receive(:parse).
      with(response)

    subject.new("signature", api_key: 123).get
  end
end
