require 'audio_file'

describe AudioFile do
  subject { AudioFile }

  let(:tags) { double("tags") }
  let(:filepath) { "fakepath" }

  context "#tags" do
    it "calls AudioFileUtils::Metadata" do
      expect(AudioFileUtils::Validator).
        to receive(:valid?).
        with(filepath).
        and_return(true)

      expect(AudioFileUtils::Metadata).
        to receive(:tags).
        with(filepath)

      subject.new(filepath).tags
    end

    it "returns an empty OpenStruct if not valid" do
      expect(AudioFileUtils::Validator).
        to receive(:valid?).
        with(filepath).
        and_return(false)

      expect(AudioFileUtils::Metadata).
        not_to receive(:tags).
        with(filepath)

      tags = subject.new(filepath).tags
      expect(tags).to be_a(OpenStruct)
    end
  end

  context "#valid?" do
    it "calls AudioFileUtils::Validator" do
      expect(AudioFileUtils::Validator).
        to receive(:valid?).
        with(filepath)

      subject.new(filepath).valid?
    end
  end

  context "#add" do
    it "creates a new CatalogRecord" do
      expect(AudioFileUtils::Validator).
        to receive(:valid?).
        with(filepath).
        and_return(true)

      expect(AudioFileUtils::Metadata).
        to receive(:tags).
        with(filepath).
        and_return(tags)

      expect(Catalog).
        to receive(:create).
        with(tags)

      subject.new(filepath).add
    end

    it "logs errors for exceptions" do
      fixed = double("safe_encoded_filename")
      import_log = Class.new
      stub_const("ImportLog", import_log)

      expect(AudioFileUtils::Validator).
        to receive(:valid?).
        with(filepath).
        and_return(true)

      expect(AudioFileUtils::Metadata).
        to receive(:tags).
        and_return(double(filename: "fakepath"))

      expect(Catalog).
        to receive(:create).
        and_raise(Exception)

      expect(import_log).
        to receive(:create!).
        with(stacktrace: "Exception",
             filename: "fakepath")

        subject.new(filepath).add
    end
  end
end
