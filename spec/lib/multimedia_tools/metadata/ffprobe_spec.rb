require 'multimedia_tools/metadata/ffprobe'

describe MultimediaTools::Metadata::Ffprobe do
  subject { MultimediaTools::Metadata::Ffprobe }

  let(:json_object) do
    <<-EOF
{
    "format": {
        "filename": "spec/fixtures/17 More Than A Mouthful.mp3",
        "nb_streams": 1,
        "nb_programs": 0,
        "format_name": "mp3",
        "format_long_name": "MP2/3 (MPEG audio layer 2/3)",
        "start_time": "0.025057",
        "duration": "46.419592",
        "size": "1856841",
        "bit_rate": "320009",
        "probe_score": 51,
        "tags": {
            "genre": "Vaporwave",
            "date": "2013",
            "album": "Nu.wav Hallucinations",
            "artist": "Nmesh",
            "title": "More Than A Mouthful",
            "track": "17",
            "copyright": "2013 AMDISCS: Futures Reserve Label, www.amdiscs.com",
            "publisher": "2013 AMDISCS: Futures Reserve Label, www.amdiscs.com"
        }
    }
}
    EOF
  end

  context "#json" do
    it "returns json object from file" do
      ffmpeg = subject.new("spec/fixtures/17 More Than A Mouthful.mp3")
      expect(ffmpeg.json).to eq(json_object)
    end

    it "is empty if cannot read file" do
      ffmpeg = subject.new("foo")
      expect(ffmpeg.json).to eq("")
    end
  end

  it "has an error message if cannot read file" do
    ffmpeg = subject.new("foo")
    expect(ffmpeg.error).to eq("foo: No such file or directory\n")
  end

  it "is not successful if cannot read file" do
    ffmpeg = subject.new("foo")
    expect(ffmpeg.success?).to be false
  end
end
