require 'filesystem_tools/move_file'

describe FilesystemTools::MoveFile do
  subject { FilesystemTools::MoveFile }

  let(:source) { "spec/fixtures/17 More Than A Mouthful.mp3" }
  let(:tags) { {artist: "Artist", album: "Album"} }

  context "#destination" do
    it "builds a destinaton from the file's artist & album tags" do
      mover = subject.new(source: source, base: "base")

      expect(MultimediaTools::Metadata::Read).
        to receive(:tags).
        with(source).
        and_return(tags)

      expect(mover.destination).
        to eq("base/Artist/Album/")
    end
  end

  context "#new_path" do
    it "returns the full path of the moved file" do
      mover = subject.new(source: source, base: "base")

      expect(MultimediaTools::Metadata::Read).
        to receive(:tags).
        with(source).
        and_return(tags)

      expect(mover.new_path).
        to eq("base/Artist/Album/17 More Than A Mouthful.mp3")
    end
  end

  context "#mkpath" do
    it "makes path for #destination" do
      expect(MultimediaTools::Metadata::Read).
        to receive(:tags).
        with(source).
        and_return(tags)

      expect(FileUtils).
        to receive(:mkdir_p).
        with("base/Artist/Album/")

      subject.new(source: source, base: "base").mkpath
    end
  end

  context "#moves" do
    it "moves #source to #destination" do
      expect(MultimediaTools::Metadata::Read).
        to receive(:tags).
        with(source).
        and_return(tags)

      expect(FileUtils).
        to receive(:mv).
        with(source, "base/Artist/Album/")

      subject.new(source: source, base: "base").move
    end
  end

  context "#relocate" do
    it "makes #destination and moves #source to #destination" do
      movefile = subject.new(source: source, base: "base")
      expect(movefile).to receive(:mkpath).and_return(true)
      expect(movefile).to receive(:move)
      movefile.relocate
    end

    it "returns false if missing Artist" do
      movefile = subject.new(source: "foo", base: "base")

      expect(MultimediaTools::Metadata::Read).
        to receive(:tags).
        with("foo").
        and_return({album: "foo"})

      expect(movefile.relocate).to be false
    end

    it "returns false if missing Album" do
      movefile = subject.new(source: "foo", base: "base")

      expect(MultimediaTools::Metadata::Read).
        to receive(:tags).
        with("foo").
        and_return({artist: "foo"})

      expect(movefile.relocate).to be false
    end
  end
end
