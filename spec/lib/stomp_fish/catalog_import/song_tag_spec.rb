require 'stomp_fish/catalog_import/song_tag'

module StompFish
  module CatalogImport
    describe SongTag do

      let(:json_object) do
        <<-EOF
{
    "format": {
        "Filename": "spec/fixtures/17 More Than A Mouthful.mp3",
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
            "ARTIST": "Nmesh",
            "TITLE": "More Than A Mouthful",
            "TRACK": "17",
            "copyright": "2013 AMDISCS: Futures Reserve Label, www.amdiscs.com",
            "publisher": "2013 AMDISCS: Futures Reserve Label, www.amdiscs.com"
        }
    }
}
        EOF
      end

      it "converts ffprobe json to a sanitized hash" do
        st = SongTag.new(json_object)
        expect(st.clean).to eq({"genre"=>"Vaporwave",
           "date"=>"2013",
           "album"=>"Nu.wav Hallucinations",
           "artist"=>"Nmesh",
           "title"=>"More Than A Mouthful",
           "track"=>"17",
           "copyright"=>"2013 AMDISCS: Futures Reserve Label, www.amdiscs.com",
           "publisher"=>"2013 AMDISCS: Futures Reserve Label, www.amdiscs.com",
           "filename"=>"spec/fixtures/17 More Than A Mouthful.mp3",
           "nb_streams"=>1, "nb_programs"=>0, "format_name"=>"mp3",
           "format_long_name"=>"MP2/3 (MPEG audio layer 2/3)",
           "start_time"=>"0:00:00.000000",
           "duration"=>"0:00:46.419592",
           "size"=>"1.770822 Mibyte",
           "bit_rate"=>"320.009000 Kbit/s",
           "probe_score"=>51
        })
      end
    end
  end
end
