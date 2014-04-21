require 'importors/auto_import'

describe Importors::AutoImport do
  let(:settings) { Class.new }
  subject { Importors::AutoImport }

  context "#start!" do
    let(:audio_file) { double(new_path: "newpath", add: "", relocate: "") }
    let(:event) { double("event", each: "") }
    let(:file) { double("file") }

    it "relocates & imports files from a watched directory" do
      stub_const("MONITOR_SETTINGS", settings)

      expect(Monitors::DirectoryMonitor).
        to receive(:listen).
        with("here").
        and_yield(event)

      expect(event).
        to receive(:each).
        and_yield(file)

      expect(AudioFile).
        to receive(:new).
        with(file).
        and_return(audio_file)

      expect(audio_file).
        to receive(:relocate).
        and_return(true)

      expect(AudioFile).
        to receive(:new).
        with("newpath").
        and_return(audio_file)

      expect(audio_file).to receive(:add)

      subject.new(watch_dir: "here", import_dir: "there").start
    end

    it "does not add the file it cannot relocate it" do
      stub_const("MONITOR_SETTINGS", settings)

      expect(Monitors::DirectoryMonitor).
        to receive(:listen).
        and_yield(event)

      expect(event).
        to receive(:each).
        and_yield(file)

      expect(AudioFile).
        to receive(:new).
        with(file).
        and_return(audio_file)

      expect(audio_file).
        to receive(:relocate).
        and_return(false)

      expect(AudioFile).
        not_to receive(:new).
        with("newpath")

      subject.new(watch_dir: "here", import_dir: "there").start
    end
  end
end
