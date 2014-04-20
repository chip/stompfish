require 'catalog_record/song_file_record'

describe CatalogRecord::SongFileRecord do
  subject { CatalogRecord::SongFileRecord }

  let(:tags) do 
    double(filename: "filename", bit_rate: 12345,
     duration: 123, format: "format",
     filesize: 12345)
  end

  let(:song_file_model) { Class.new }
  let(:song_instance) { double(:update) }
  let(:stat_file) { double(:mtime) }

  before { stub_const("SongFile", song_file_model) }

  it "adds a SongFile" do

    expect(song_file_model).
      to receive(:find_or_create_by).
      with(filename: "filename").
      and_return(song_instance)

    expect(File).
      to receive(:stat).
      with("filename").
      and_return(stat_file)

    expect(stat_file).
      to receive(:mtime).
      and_return("fake datetime")

    expect(song_instance).
      to receive(:update).
      with(filesize: 12345,
           bit_rate: 12345,
           format: "format",
           duration: 123,
           fileable_id: 1,
           mtime: "fake datetime",
           fileable_type: "Song")

   subject.add(tags, 1, song_file_model: song_file_model)
  end
end
