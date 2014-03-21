require 'catalog/import/import_directory'

module Catalog
  module Import
    describe ImportDirectory do
      it "imports all files in a directory" do
        expect(ImportFile).
          to receive(:add).
          with("spec/fixtures/17 More Than A Mouthful.mp3")

        ImportDirectory.new("spec/fixtures").scan!
      end

      it "raises error if not a directory" do
        expect do
          ImportDirectory.new("spec/fixtures/17 More Than A Mouthful.mp3").directory
        end.to raise_error(InvalidDirectory)
      end

      it "returns the directory if exists" do
        imp = ImportDirectory.new("spec/fixtures")
        expect(imp.directory).to eq("spec/fixtures")
      end

      it "imports only audio files" do
        id = ImportDirectory.new("spec/fixtures")
        expect(id.files).to eq ["spec/fixtures/17 More Than A Mouthful.mp3"]
      end
    end
  end
end
