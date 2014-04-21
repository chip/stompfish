require 'importors/auto_import'

describe Importors::AutoImport do
  let(:settings) { Class.new }
  subject { Importors::AutoImport }

  context "#start!" do
    let(:audio_file) { double(valid?: "", add: "") }
    let(:event) { double("event", each: "") }
    let(:file) { double("file") }
    let(:mover) { double(relocate: "", new_path: "newpath") }

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
        to receive(:valid?).
        and_return(true)

      expect(AudioFileUtils::Move).
        to receive(:new).
        with(source: file, base: "there").
        and_return(mover)

      expect(mover).
        to receive(:relocate).
        and_return(true)

      expect(AudioFile).
        to receive(:new).
        with("newpath").
        and_return(audio_file)

      expect(audio_file).to receive(:add)

      subject.new(watch_dir: "here", import_dir: "there").start!
    end

    it "does not add the file if invalid" do
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
        to receive(:valid?).
        and_return(false)

      expect(audio_file).
        not_to receive(:add)

      subject.new(watch_dir: "here", import_dir: "there").start!
    end

    it "does not move the file it cannot relocate it" do
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
        to receive(:valid?).
        and_return(true)

      expect(AudioFileUtils::Move).
        to receive(:new).
        and_return(mover)

      expect(mover).
        to receive(:relocate).
        and_return(false)

      expect(AudioFile).
        not_to receive(:new).
        with(mover.new_path)

      subject.new(watch_dir: "here", import_dir: "there").start!
    end
  end

  context "#watch_dir" do
    it "uses default in config/monitor_settings.yml" do
      stub_const("MONITOR_SETTINGS", {"watch_dir" => "/mnt/music/TMP"})
      importer = subject.new
      expect(importer.watch_dir).to eq("/mnt/music/TMP")
    end
  end

  context "#import_dir" do
    it "uses default in config/monitor_settings.yml" do
      stub_const("MONITOR_SETTINGS", {"import_dir" => "/mnt/music"})
      importer = subject.new
      expect(importer.import_dir).to eq("/mnt/music")
    end
  end
end
