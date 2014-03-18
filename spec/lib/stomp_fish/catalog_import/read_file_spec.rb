require 'stomp_fish/catalog_import/read_file'

module StompFish
  module CatalogImport
    describe ReadFile do
      it "has tags for a file" do
        json = double("json")

        expect(Ffprobe).to receive(:json).with("spec/fixtures/17 More Than A Mouthful.mp3") { json }
        expect(SongTag).to receive(:clean).with(json)
        ReadFile.new("spec/fixtures/17 More Than A Mouthful.mp3").tags
      end
    end
  end
end
