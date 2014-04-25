require 'audio_file_utils/metadata_core/filesystem_info'

describe AudioFileUtils::MetadataCore::FilesystemInfo do
  subject { described_class }

  let(:file) { __FILE__ }
  let(:info)  { subject.new(file).info }

  it "has a filename" do
    expect(info.filename).to eq(file)
  end

  it "has a filesize" do
    expect(info.filesize).to eq(422)
  end

  it "has a format" do
    expect(info.format).to eq("rb")
  end
end
