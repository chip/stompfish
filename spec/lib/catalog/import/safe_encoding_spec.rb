require 'catalog/import/safe_encoding'

module Catalog
  module Import
    describe SafeEncoding do
      it "replaces bad encoding" do
        string = "bad\xE9encoding"
        fixed = SafeEncoding.ensure(string)
        expect(fixed).to eq("badencoding")
      end

      it "does not replace safe encoding" do
        string = "good encoding"
        fixed = SafeEncoding.ensure(string)
        expect(fixed).to eq("good encoding")
      end

      it "has valid_encoding if it is valid" do
        string = SafeEncoding.new(string)
        expect(string).to have_valid_encoding
      end

      it "converts value to string" do
        string = 1
        fixed = SafeEncoding.ensure(string)
        expect(fixed).to eq("1")
      end
    end
  end
end
