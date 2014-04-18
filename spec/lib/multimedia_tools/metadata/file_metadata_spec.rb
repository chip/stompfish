require 'multimedia_tools/metadata/file_metadata'

describe MultimediaTools::Metadata::FileMetadata do
  subject { MultimediaTools::Metadata::FileMetadata }

  let(:tags) do
    double(album: "album", artist: "artist", date: "1999",
           genre: "genre", title: "title", track: "1", year: nil)
  end

  let(:props) do
    double(bit_rate: "123", duration: "456", bitrate: nil, length: nil)
  end

  let(:file) { "spec/fixtures/17 More Than A Mouthful.mp3" }

  let(:meta) { subject.new(tags: tags, filename: file, props: props).process! }

  context "#process!" do
    context "@tags" do
      it "has an album" do
        expect(meta.album).to eq("album")
      end

      it "has an artist" do
        expect(meta.artist).to eq("artist")
      end

      it "has an genre" do
        expect(meta.genre).to eq("genre")
      end

      it "has a title" do
        expect(meta.title).to eq("title")
      end

      it "has a track (as integer)" do
        expect(meta.track).to eq(1)
      end

      context "#date" do
        it "has a date (as integer)" do
          expect(meta.date).to eq(1999)
        end

        it "uses tags.year if exists" do
          tags = double(album: "album", artist: "artist", date: "1999",
                        genre: "genre", title: "title", track: "1", year: 1975)

          meta = subject.new(tags: tags, filename: file, props: props).process!
          expect(meta.date).to eq(1975)
        end
      end
    end

    context "@props" do
      context "#bit_rate" do
        it "has a bit_rate (as integer)" do
          expect(meta.bit_rate).to eq(123)
        end

        it "uses props.bitrate if exists" do
          props = double(bit_rate: "123", duration: "456", bitrate: 789, length: 876)
          meta = subject.new(tags: tags, filename: file, props: props).process!
          expect(meta.bit_rate).to eq(789)
        end
      end

      context "#duration" do
        it "has a duration (as integer)" do
          expect(meta.duration).to eq(456)
        end

        it "uses props.length if exists" do
          props = double(bit_rate: "123", duration: "456", bitrate: nil, length: 876)
          meta = subject.new(tags: tags, filename: file, props: props).process!
          expect(meta.duration).to eq(876)
        end
      end
    end

    context "@source_file" do
      it "has a filename" do
        expect(meta.filename).to eq(file)
      end

      it "has a filesize" do
        expect(meta.filesize).to eq(1856841)
      end

      it "has a format" do
        expect(meta.format).to eq("mp3")
      end
    end
  end
end
