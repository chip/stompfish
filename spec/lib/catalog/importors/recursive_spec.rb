require 'catalog/importors/recursive'

describe Catalog::Importors::Recursive do
  subject { Catalog::Importors::Recursive }

  context "#scan" do
    it "imports all files in a directory" do
      expect(Catalog::Importors::SingleFile).
        to receive(:add).
        with("spec/fixtures/17 More Than A Mouthful.mp3")

      subject.new("spec/fixtures").scan
    end

    it "takes an optional block" do
      expect(Catalog::Importors::SingleFile).to receive(:add)
      expect($stdout).to receive(:puts).with("Hello")
      subject.new("spec/fixtures").scan { $stdout.puts "Hello" }
    end
  end
end
