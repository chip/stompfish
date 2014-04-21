require 'audio_file'

describe AudioFile do
  let(:filepath) { "fakepath" }

  subject { AudioFile }

  context "#relocate" do
    it "calls AudioFileUtils::Move.relocate" do
      tags = double(album: "album", artist: "artist")
      audio_file = subject.new(filepath)

      expect(audio_file).
        to receive(:valid?).
        and_return(true)

      expect(AudioFileUtils::Metadata).
        to receive(:tags).
        with("fakepath").
        and_return(tags)

      expect(AudioFileUtils::Move).
        to receive(:relocate).
        with(base: "basepath", source: audio_file)
      
      audio_file.relocate(base: "basepath")
    end

    it "does not relocate if invalid artist tag" do
      tags = double(album: "album", artist: nil)
      audio_file = subject.new(filepath)

      expect(audio_file).
        to receive(:valid?).
        and_return(true)

      expect(AudioFileUtils::Metadata).
        to receive(:tags).
        with("fakepath").
        and_return(tags)

      expect(AudioFileUtils::Move).
        not_to receive(:relocate).
        with(base: "basepath", source: audio_file)
      
      audio_file.relocate(base: "basepath")
    end

    it "does not relocate if invalid album tag" do
      tags = double(album: nil, artist: "artist")
      audio_file = subject.new(filepath)

      expect(audio_file).
        to receive(:valid?).
        and_return(true)

      expect(AudioFileUtils::Metadata).
        to receive(:tags).
        with("fakepath").
        and_return(tags)

      expect(AudioFileUtils::Move).
        not_to receive(:relocate).
        with(base: "basepath", source: audio_file)
      
      audio_file.relocate(base: "basepath")
    end
  end

  context "#new_path" do
    it "returns new_path if relocated" do
      tags = double(album: "album", artist: "artist")
      audio_file = subject.new(filepath)

      expect(audio_file).
        to receive(:valid?).
        and_return(true)

      expect(AudioFileUtils::Metadata).
        to receive(:tags).
        and_return(tags)

      expect(AudioFileUtils::Move).
        to receive(:relocate).
        and_return("newpath")

      audio_file.relocate(base: "basepath")

      expect(audio_file.new_path).to eq("newpath")
    end

    it "returns nil if not relocated" do
      audio_file = subject.new(filepath)
      expect(audio_file.new_path).to be_nil
    end
  end

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
      tags = double("tags")

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
