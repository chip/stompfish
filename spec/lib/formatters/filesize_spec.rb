require 'formatters/filesize'

module Formatters
  describe Filesize do
    context ".to_human_size" do
      it "formats a @filesize to be human readable" do
        filesize = 46779916
        formatted = Filesize.to_human_size(filesize)
        expect(formatted).to eq "44.6 MB"
      end
    end

    context "#filesize" do
      it "raises error if not a fixnum" do
        filesize = "foo"
        expect do 
          Filesize.to_human_size(filesize)
        end.to raise_error(FilesizeNotFixnum)
      end

      it "returns the filesize" do
        filesize = 1234
        formatter = Filesize.new(filesize)
        expect(formatter.filesize).to eq(1234)
      end
    end
  end
end
