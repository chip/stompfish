require 'multimedia_tools/metadata/read'

describe MultimediaTools::Metadata::Read do
  subject { MultimediaTools::Metadata::Read }

  it "has tags for a file" do
    json = double("json")

    expect(MultimediaTools::Metadata::Ffprobe).
      to receive(:json).
      with("spec/fixtures/17 More Than A Mouthful.mp3").
      and_return(json)

    expect(MultimediaTools::Metadata::CleanRawOutput).
      to receive(:clean).
      with(json)

    subject.new("spec/fixtures/17 More Than A Mouthful.mp3").tags
  end
end
