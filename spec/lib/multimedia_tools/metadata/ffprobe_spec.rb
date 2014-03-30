require 'spec_helper'

describe MultimediaTools::Metadata::Ffprobe do
  subject { MultimediaTools::Metadata::Ffprobe }

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

   expect(MultimediaTools::Metadata::SanitizeFfprobeOutput).
     to receive(:clean).
     with({"this" => "time"})

    subject.new(file).tags
  end

  it "returns #properties from file" do
    expect(Open3).to receive(:capture3) { [] }

    expect(JSON).
      to receive(:parse).
      and_return(parsed)

   expect(MultimediaTools::Metadata::SanitizeFfprobeOutput).
     to receive(:clean).
     with({"another" => "place"})

    subject.new(file).properties
  end
end
