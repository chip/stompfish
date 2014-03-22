require 'catalog/import/full_import'

module Catalog
  module Import
    describe FullImport do
      it "imports all files in a directory" do
        expect(ImportFile).
          to receive(:add).
          with("spec/fixtures/17 More Than A Mouthful.mp3")

        FullImport.new("spec/fixtures").scan
      end

      it "logs errors for exceptions" do
        fixed = double("safe_encoded_filename")
        import_log = Class.new
        stub_const("ImportLog", import_log)

        expect(ImportFile).
          to receive(:add).
          and_raise(Exception)

        expect(SafeEncoding).
          to receive(:ensure).
          with("spec/fixtures/17 More Than A Mouthful.mp3").
          and_return(fixed)

        expect(import_log).
          to receive(:create!).
          with(stacktrace: "Exception",
               filename: fixed)

        FullImport.scan("spec/fixtures")
      end
    end
  end
end
