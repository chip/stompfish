require 'catalog/import/find_files'
require 'fileutils'

module Catalog
  module Import
    describe FindFiles do
      let(:dir) { "spec/fixtures" }

      context "#files" do
        it "includes audio files in a directory" do
          files = FindFiles.new(dir).files
          expect(files).to eq(["spec/fixtures/17 More Than A Mouthful.mp3"])
        end

        it "excludes non audio files" do
          files = FindFiles.new(dir).files
          expect(files).not_to include(["spec/fixtures/non_audio.txt"])
        end

        it "returns an empty array if not a valid #directory" do
          files = FindFiles.new("foo").files
          expect(files).to eq([])
        end
      end

      context "#directory" do
        it "returns false if not a valid directory" do
          directory = FindFiles.new("foo").directory
          expect(directory).to be false
        end

        it "returns the directory" do
          directory = FindFiles.new(dir).directory
          expect(directory). to eq("spec/fixtures")
        end
      end
    end
  end
end
