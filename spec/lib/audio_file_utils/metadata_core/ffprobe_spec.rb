require 'audio_file_utils/metadata_core/ffprobe'

describe AudioFileUtils::MetadataCore::Ffprobe do
  subject { AudioFileUtils::MetadataCore::Ffprobe }

  let(:file) { double("file") }

  let(:parsed) do
    {"format" => {"another" => "place",
                  "tags" => {"this" => "time"}}}
  end

  it "returns #tags data from file" do
    expect(Open3).to receive(:capture3) { [] }

    expect(JSON).
      to receive(:parse).
      and_return(parsed)

   expect(AudioFileUtils::MetadataCore::SanitizeFfprobeOutput).
     to receive(:clean).
     with({"this" => "time"})

    subject.new(file).tags
  end

  it "returns #properties from file" do
    expect(Open3).to receive(:capture3) { [] }

    expect(JSON).
      to receive(:parse).
      and_return(parsed)

   expect(AudioFileUtils::MetadataCore::SanitizeFfprobeOutput).
     to receive(:clean).
     with({"another" => "place"})

    subject.new(file).properties
  end
end
