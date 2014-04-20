require 'audio_file_utils/metadata_core/sanitize_ffprobe_output'

describe AudioFileUtils::MetadataCore::SanitizeFfprobeOutput do
  subject { AudioFileUtils::MetadataCore::SanitizeFfprobeOutput }

  it "converts values to an OpenStruct" do
    dirty = {"FIRST" => "first", "SECOND" => "second"}
    clean = subject.new(dirty).clean
    expect(clean.first).to eq("first")
    expect(clean.second).to eq("second")
  end

  it "replaces bad string encoding" do
    dirty = {"FIRST" => "first", "SECOND" => "second"}

    expect(CharacterEncoding::ReplaceInvalidCharacters).
      to receive(:clean).
      with("first")

    expect(CharacterEncoding::ReplaceInvalidCharacters).
      to receive(:clean).
      with("second")

    clean = subject.new(dirty).clean
  end
end
