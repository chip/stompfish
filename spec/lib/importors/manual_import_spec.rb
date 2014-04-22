require 'importors/manual_import'

describe Importors::ManualImport do
  subject { Importors::ManualImport }

  let(:directory) { double("directory") }
  let(:audio_file) { double(valid?: "", add: "") }
  let(:file) { "foobar.txt" }
  let(:files) { [file] }

  context "#scan" do
    it "imports all files in a directory" do
      expect(Find).
        to receive(:find).with(directory).
        and_return(files)

      expect(AudioFile).
        to receive(:new).
        with(file).
        and_return(audio_file)

      expect(audio_file).
        to receive(:valid?).
        and_return(true)

      expect(audio_file).
        to receive(:add)

      subject.new(directory).scan
    end

    it "does import a file if invalid" do
      expect(Find).
        to receive(:find).with(directory).
        and_return(files)

      expect(AudioFile).
        to receive(:new).
        with(file).
        and_return(audio_file)

      expect(audio_file).
        to receive(:valid?).
        and_return(false)

      expect(audio_file).
        not_to receive(:add)

      subject.new(directory).scan
    end

    it "takes an optional block" do
      expect(Find).
        to receive(:find).with(directory).
        and_return(files)

      expect(AudioFile).
        to receive(:new).
        with(file).
        and_return(audio_file)

      expect(audio_file).
        to receive(:valid?).
        and_return(true)

      expect(audio_file).to receive(:add)

      expect($stdout).
        to receive(:puts).
        with(".")

      subject.new(directory).scan { $stdout.puts "." }
    end

    it "calls ImportError to rescue error" do
      import_log = Class.new
      stub_const("ImportLog", import_log)

      expect(Find).
        to receive(:find).with(directory).
        and_return(files)

      expect(AudioFile).
        to receive(:new).
        and_raise(Exception)

      expect(ImportLog).
        to receive(:create!).
        with(stacktrace: "Exception", filepath: "foobar.txt")

      subject.new(directory).scan
    end
  end
end
