require 'importors/import_error'

describe Importors::ImportError do
  let(:fake_class) { Class.new }
  let(:import_log) { Class.new }
  let(:my_error) { StandardError.new }

  subject { Importors::ImportError }

  before do
    stub_const("FakeClass", fake_class)
    stub_const("ImportLog", import_log)
    stub_const("MyError", my_error)
  end

  context ".capture" do
    it "takes an optional block" do
      expect($stdout).
        to receive(:puts).
        with(".")

      subject.capture { $stdout.puts "." }
    end

    it "rescues an Exception" do
      expect do
        expect(ImportLog).to receive(:create!)

        subject.capture { raise Exception }
      end.not_to raise_error
    end

    it "creates an ImportLog entry for error" do
      file = double("file")

      expect(FakeClass).
        to receive(:read).
        with("foo").
        and_raise(my_error, "foo")

      expect(ImportLog).
        to receive(:create!).
        with(stacktrace: "foo", filepath: file)

      subject.capture(filename: file) { FakeClass.read("foo") }
    end
  end
end
