require 'monitors/directory_monitor'

describe Monitors::DirectoryMonitor do
  let(:directory) { "spec/fixtures" }
  let(:notifier) { double("notifier") }
  let(:modified) { double("modified") }
  let(:added) { double("added") }
  let(:fake) { Class.new }
  subject { Monitors::DirectoryMonitor }

  context "#listen" do
    it "imports files from @directory being watched" do
      expect(Listen).
        to receive(:to).
        with(directory).
        and_return(notifier).
        and_yield(modified, added)

      expect($stdout).to receive(:puts).with(added)

      expect(notifier).to receive(:start)

      subject.new(directory).listen { |added| $stdout.puts(added) }
    end
  end

  context "#directory" do
    it "returns @directory" do
      dir = subject.new("spec/fixtures").directory
      expect(dir).to eq("spec/fixtures")
    end
  end
end
