require 'spec_helper'

describe Catalog::Importors::Recursive do
  subject { Catalog::Importors::Recursive }

  let(:directory) { double("directory") }
  let(:file) { double(filename: "foobar") }
  let(:files) { [file] }

  context "#scan" do
    it "imports all files in a directory" do
      expect(FilesystemTools::FindFiles).
        to receive(:files).with(directory).
        and_return(files)

      expect(SongFile).
        to receive(:find_by).
        and_return(false)

      expect(Catalog::Importors::SingleFile).
        to receive(:add).
        with(filepath: file)

      subject.new(directory).scan
    end

    it "skips the file if it already exists" do
      expect(FilesystemTools::FindFiles).
        to receive(:files).with(directory).
        and_return(files)

      expect(SongFile).
        to receive(:find_by).
        with(filename: file).
        and_return(true)

      expect(Catalog::Importors::SingleFile).
        not_to receive(:add)

      subject.new(directory).scan
    end

    it "takes an optional block" do
      expect(FilesystemTools::FindFiles).to receive(:files) { files }
      expect(SongFile).to receive(:find_by).and_return(false)
      expect(Catalog::Importors::SingleFile).to receive(:add)
      expect($stdout).to receive(:puts).with("Hello")
      subject.scan("spec/fixtures") { $stdout.puts "Hello" }
    end
  end
end
