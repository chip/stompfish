require 'multimedia_tools/metadata/clean_raw_output'
require 'multimedia_tools/metadata/ffprobe'

describe MultimediaTools::Metadata::CleanRawOutput do
  subject { MultimediaTools::Metadata::CleanRawOutput }

  let(:json_object) do
    <<-EOF
{
    "format": {
        "filename": "spec/fixtures/17 More Than A Mouthful.mp3",
        "nb_streams": 1,
        "nb_programs": 0,
        "format_name": "mp3",
        "format_long_name": "MP2/3 (MPEG audio layer 2/3)",
        "start_time": "0.000000",
        "duration": "46.419592",
        "size": "1856841",
        "bit_rate": "320009",
        "probe_score": 51,
        "tags": {
            "genre": "Vaporwave",
            "date": "2013",
            "album": "Nu.wav Hallucinations",
            "ARTIST": "Nmesh",
            "TITLE": "More Than A Mouthful",
            "TRACK": "17\xE9",
            "copyright": "2013 AMDISCS: Futures Reserve Label, www.amdiscs.com",
            "publisher": "2013 AMDISCS: Futures Reserve Label, www.amdiscs.com"
        }
    }
}
    EOF
  end

  it "converts ffprobe json to a sanitized hash" do
    st = subject.new(json_object)
    expect(st.clean).to eq({
      genre: "Vaporwave",
      date: "2013",
      album: "Nu.wav Hallucinations",
      artist: "Nmesh",
      title: "More Than A Mouthful",
      track: "17",
      copyright: "2013 AMDISCS: Futures Reserve Label, www.amdiscs.com",
      publisher: "2013 AMDISCS: Futures Reserve Label, www.amdiscs.com",
      filename: "spec/fixtures/17 More Than A Mouthful.mp3",
      nb_streams: "1",
      nb_programs: "0",
      format_name: "mp3",
      format_long_name: "MP2/3 (MPEG audio layer 2/3)",
      start_time: "0.000000",
      duration: "46.419592",
      size: "1856841",
      bit_rate: "320009",
      probe_score: "51"
    })
  end

  it "still returns 'format' if missing 'tags' attribute" do
    invalid_object = '{"format":{"size":1234}}'
    st = subject.new(invalid_object)
    expect(st.clean).to eq({size: "1234"})
  end
end
