require 'catalog/importors/auto_import'

describe Catalog::Importors::AutoImport do
  let(:settings) { Class.new }
  subject { Catalog::Importors::AutoImport }

  context "#start!" do
    let(:event) { double("event", each: "") }
    let(:file) { double("file") }
    let(:mover) { double(relocate: "", new_path: "newpath") }

    it "relocates & imports files from a watched directory" do
      stub_const("MONITOR_SETTINGS", settings)

      expect(Catalog::Monitors::DirectoryWatcher).
        to receive(:listen).
        with("here").
        and_yield(event)

      expect(event).
        to receive(:each).
        and_yield(file)

      expect(AudioFileUtils::MoveFile).
        to receive(:new).
        with(source: file, base: "there").
        and_return(mover)

      expect(mover).
        to receive(:relocate).
        and_return(true)

      expect(AudioFile).
        to receive(:add).
        with("newpath")

      subject.new(watch_dir: "here", import_dir: "there").start!
    end

    context "does not relocate file" do
      it "does not try to import the file" do
        stub_const("MONITOR_SETTINGS", settings)

        expect(Catalog::Monitors::DirectoryWatcher).
          to receive(:listen).
          and_yield(event)

        expect(event).
          to receive(:each).
          and_yield(file)

        expect(AudioFileUtils::MoveFile).
          to receive(:new).
          and_return(mover)

        expect(mover).
          to receive(:relocate).
          and_return(false)

        expect(AudioFile).
          not_to receive(:add)

        subject.new(watch_dir: "here", import_dir: "there").start!
      end
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
