require 'catalog/importors/recursive'

describe Catalog::Importors::Recursive do
  subject { Catalog::Importors::Recursive }
  it "imports all files in a directory" do
    expect(Catalog::Importors::SingleFile).
      to receive(:add).
      with("spec/fixtures/17 More Than A Mouthful.mp3")

    subject.new("spec/fixtures").scan
  end
end
