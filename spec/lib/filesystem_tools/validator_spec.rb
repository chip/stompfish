require 'filesystem_tools/validator'

describe FilesystemTools::Validator do
  let(:filepath) { "spec/fixtures/17 More Than A Mouthful.mp3" }
  subject { FilesystemTools::Validator }

  context "#valid?" do
    it "is true if is an audio file" do
      expect(subject.new(filepath)).to be_valid
    end

    it "is false if not a file" do
      expect(subject.new("foo")).not_to be_valid
    end

    it "is false if not an audio file" do
      expect(subject.new("spec/fixtures/non_audio.txt")).not_to be_valid
    end
  end
end
