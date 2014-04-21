require 'audio_file_utils/move'

describe AudioFileUtils::Move do
  subject { AudioFileUtils::Move }

  let(:filepath) { "spec/fixtures/17 More Than A Mouthful.mp3" }
  let(:tags) { double(artist: "Artist", album: "Album") }
  let(:audio_file)  { double(tags: tags, filepath: filepath) }

  context "#relocate" do
    it "makes #destination and moves #source to #destination" do
      movefile = subject.new(source: audio_file, base: "base")
      expect(movefile).to receive(:mkpath).and_return(true)
      expect(movefile).to receive(:move)
      movefile.relocate
    end

    it "returns the newpath" do
      movefile = subject.new(source: audio_file, base: "base")
      expect(movefile).to receive(:mkpath).and_return(true)
      expect(movefile).to receive(:move).and_return(true)
      expect(movefile.relocate).to eq("base/Artist/Album/17 More Than A Mouthful.mp3")
    end

    it "does not move if it cannot mkpath" do
      movefile = subject.new(source: audio_file, base: "base")
      expect(movefile).to receive(:mkpath).and_return(false)
      expect(movefile).not_to receive(:move)
      movefile.relocate
    end

    it "returns false if it cannot mkpath or move" do
      movefile = subject.new(source: audio_file, base: "base")
      expect(movefile).to receive(:mkpath).and_return(false)
      expect(movefile).not_to receive(:move)
      expect(movefile.relocate).to be false
    end
  end
end
