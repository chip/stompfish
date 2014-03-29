require 'catalog/import/monitor'

module Catalog
  module Import
    describe Monitor do
      let(:directory) { "spec/fixtures" }
      let(:notifier) { double("notifier") }
      let(:event) { double(:event, absolute_name: directory) }
      let(:fake) { Class.new }

      context "#listen" do
        it "imports files from @directory being watched" do
          stub_const("Fake", fake)

          expect(INotify::Notifier).
            to receive(:new).
            and_return(notifier)

          expect(notifier).
            to receive(:watch).
            with("spec/fixtures", :create, :recursive, :onlydir).
            and_yield(event)

          expect(fake).
            to receive(:new).
            with("spec/fixtures")

          expect(Thread).to receive(:new).and_yield

          expect(notifier).to receive(:run)

          Monitor.new(directory).listen { |event| fake.new(event) }
        end

        it "calls block on directory if event happened on file" do
          stub_const("Fake", fake)
          file_event = double(:event, absolute_name: "spec/fixtures/file.txt")

          expect(INotify::Notifier).to receive(:new).and_return(notifier)
          expect(notifier).to receive(:watch).and_yield(file_event)

          expect(fake).
            to receive(:new).
            with("spec/fixtures")

          expect(Thread).to receive(:new).and_yield

          expect(notifier).to receive(:run)

          Monitor.new(directory).listen { |event| fake.new(event) }
        end

        it "calls block on directory if event happened on directory" do
          stub_const("Fake", fake)
          dir_event = double(:event, absolute_name: "spec/fixtures")

          expect(INotify::Notifier).to receive(:new).and_return(notifier)
          expect(notifier).to receive(:watch).and_yield(dir_event)

          expect(fake).
            to receive(:new).
            with("spec/fixtures")

          expect(Thread).to receive(:new).and_yield

          expect(notifier).to receive(:run)

          Monitor.new(directory).listen { |event| fake.new(event) }
        end
      end

      context "@ignore" do
        it "ignores select directories" do
          Monitor.new(directory, ignore: "spec/fixtures/ignore")
          expect(INotify::Notifier::RECURSIVE_BLACKLIST).
            to include("spec/fixtures/ignore")
        end

        it "adds no ignores if none specified" do
          Monitor.new(directory)
          expect(INotify::Notifier::RECURSIVE_BLACKLIST).
            not_to include(nil)
        end
      end

      context "#directory" do
        it "raises error if directory does not exist" do
          expect do
            Monitor.new("foo").directory
          end.to raise_error DirectoryNotFound
        end

        it "returns @directory" do
          dir = Monitor.new("spec/fixtures").directory
          expect(dir).to eq("spec/fixtures")
        end
      end
    end
  end
end
