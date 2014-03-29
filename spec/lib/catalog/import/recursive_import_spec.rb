require 'catalog/import/recursive_import'

module Catalog
  module Import
    describe RecursiveImport do
      it "imports all files in a directory" do
        expect(ImportFile).
          to receive(:add).
          with("spec/fixtures/17 More Than A Mouthful.mp3")

        RecursiveImport.new("spec/fixtures").scan
      end
    end
  end
end
