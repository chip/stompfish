require 'catalog/importors/recursive'

describe Catalog::Importors::Recursive do
  subject { Catalog::Importors::Recursive }

  let(:directory) { double("directory") }
  let(:file) { double(filename: "foobar.txt") }
  let(:files) { [file] }

  context "#scan" do
    it "imports all files in a directory" do
      expect(Find).
        to receive(:find).with(directory).
        and_return(files)

      expect(AudioFile).
        to receive(:add).
        with(file)

      subject.new(directory).scan
    end
  end
end
