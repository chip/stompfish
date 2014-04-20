require 'catalog/importors/audio_file'

describe Catalog::Importors::AudioFile do
  subject { Catalog::Importors::AudioFile }

  let(:tags) { double("tags") }
  let(:filepath) { "fakepath" }

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

      expect(Catalog::DatabaseTools::CatalogRecord).
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
        and_return(true)

      expect(AudioFileUtils::Metadata).
        to receive(:tags).
        and_return({filename: "fakepath"})

      expect(Catalog::DatabaseTools::CatalogRecord).
        to receive(:create).
        and_raise(Exception)

      expect(import_log).
        to receive(:create!).
        with(stacktrace: "Exception",
             filename: "fakepath")

        subject.new(filepath).add
    end
  end

  it "ignores invalid files" do
    expect(AudioFileUtils::Validator).
      to receive(:valid?).
      with(filepath).
      and_return(false)

    audio_file = subject.new(filepath)
    expect(audio_file.add).to be_nil
  end
end
