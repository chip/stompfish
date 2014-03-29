require 'multimedia_tools/metadata/tag_store'

describe MultimediaTools::Metadata::TagStore do
  subject { MultimediaTools::Metadata::TagStore }

  let(:directory) { "some dir" }
  let(:file) { double }
  let(:files) { [file] }

  it "returns all tags in directory" do
    expect(FilesystemTools::FindFiles).
      to receive(:files).
      with(directory).
      and_return(files)

    expect(Parallel).
      to receive(:map).
      with(files, in_processes: 8).
      and_yield(file)

    expect(MultimediaTools::Metadata::Read).
      to receive(:tags).
      with(file)

    subject.new(directory).store
  end
end
