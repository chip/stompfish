require 'stomp_fish/catalog_import/ffprobe'

module StompFish
  module CatalogImport
    describe Ffprobe do
      let(:json_object) do
        <<-EOF
{
    "format": {
        "filename": "spec/fixtures/17 More Than A Mouthful.mp3",
        "nb_streams": 1,
        "nb_programs": 0,
        "format_name": "mp3",
        "format_long_name": "MP2/3 (MPEG audio layer 2/3)",
        "start_time": "0:00:00.000000",
        "duration": "0:00:46.419592",
        "size": "1.770822 Mibyte",
        "bit_rate": "320.009000 Kbit/s",
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
          ffmpeg = Ffprobe.new("spec/fixtures/17 More Than A Mouthful.mp3")
          expect(ffmpeg.json).to eq(json_object)
        end

        it "is empty if cannot read file" do
          ffmpeg = Ffprobe.new("foo")
          expect(ffmpeg.json).to eq("")
        end
      end

      it "has an error message if cannot read file" do
        ffmpeg = Ffprobe.new("foo")
        expect(ffmpeg.error).to eq("foo: No such file or directory\n")
      end

      it "is not successful if cannot read file" do
        ffmpeg = Ffprobe.new("foo")
        expect(ffmpeg.success?).to be false
      end
    end
  end
end
