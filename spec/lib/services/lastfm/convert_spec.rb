require 'services/lastfm/convert'

describe Services::Lastfm::Convert do
  subject { described_class }

  let(:image) { "spec/fixtures/sample.png" }

  it "replaces a source image with a new one called 'folder.jpg'" do
    image_list = double("Magick::ImageList")

    expect(Magick::ImageList).
      to receive(:new).
      with(image).
      and_return(image_list)

    expect(image_list).
      to receive(:write).
      with("spec/fixtures/folder.jpg").
      and_return(true)

    expect(FileUtils).
      to receive(:rm_f).
      with(image)

    subject.new(image).convert
  end

  it "returns new image path" do
    converter = subject.new(image)

    expect(converter.new_path).
      to eq("spec/fixtures/folder.jpg")
  end
end
