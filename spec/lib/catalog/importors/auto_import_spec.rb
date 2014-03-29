require 'spec_helper'

describe Catalog::Importors::AutoImport do
  subject { Catalog::Importors::AutoImport }

  context "#start!" do
    let(:event) { double("event") }
    let(:file) { double("file") }
    let(:mover) { double(relocate: "", new_path: "newpath") }
    let(:files) { [file] }

    it "relocates & imports files from a watched directory" do
      expect(Catalog::Monitors::DirectoryWatcher).
        to receive(:listen).
        with("here").
        and_yield(event)

      expect(FilesystemTools::FindFiles).
        to receive(:files).
        with(event).
        and_return(files)

      expect(FilesystemTools::MoveFile).
        to receive(:new).
        with(source: file, base: "there").
        and_return(mover)

      expect(mover).
        to receive(:relocate).
        and_return(true)

      expect(Catalog::Importors::SingleFile).
        to receive(:add).
        with("newpath")

      subject.new(watch_dir: "here", import_dir: "there", sleep_time: 0).start!
    end

    context "does not relocate file" do
      it "does not try to import the file" do
        expect(Catalog::Monitors::DirectoryWatcher).
          to receive(:listen).
          and_yield(event)

        expect(FilesystemTools::FindFiles).
          to receive(:files).
          and_return(files)

        expect(FilesystemTools::MoveFile).
          to receive(:new).
          and_return(mover)

        expect(mover).
          to receive(:relocate).
          and_return(false)

        expect(Catalog::Importors::SingleFile).
          not_to receive(:add)

        subject.new(watch_dir: "here", import_dir: "there", sleep_time: 0).start!
      end
    end
  end

  context "#watch_dir" do
    it "uses default in config/monitor_settings.yml" do
      importer = subject.new
      expect(importer.watch_dir).to eq("/mnt/music/TMP")
    end
  end

  context "#import_dir" do
    it "uses default in config/monitor_settings.yml" do
      importer = subject.new
      expect(importer.import_dir).to eq("/mnt/music")
    end
  end

  context "#sleep_time" do
    it "defaults to 3" do
      importer = subject.new
      expect(importer.sleep_time).to eq(3)
    end
  end
end
