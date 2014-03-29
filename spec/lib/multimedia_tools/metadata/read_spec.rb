require 'multimedia_tools/metadata/read'

describe MultimediaTools::Metadata::Read do
  subject { MultimediaTools::Metadata::Read }

  let(:file) { "spec/fixtures/17 More Than A Mouthful.mp3" }

  it "has tags for a file" do
    tags = MultimediaTools::Metadata::Read.tags(file)
    expect(tags).to eq({
      album: "Nu.wav Hallucinations",
      artist: "Nmesh",
      bit_rate: 319,
      date: 2013,
      duration: 46,
      filename: "spec/fixtures/17 More Than A Mouthful.mp3",
      filesize: 1856841,
      format: "mp3",
      genre: "Vaporwave",
      title: "More Than A Mouthful",
      track: 17})
  end
end
