module CatalogRecord
  class SongFileRecord
    attr_reader :tags, :song_id, :song_file_model

    def initialize(tags, song_id, options = {})
      @tags = tags
      @song_id = song_id
      @song_file_model = options[:song_file_model] || SongFile
    end

    def add
      file = song_file_model.find_or_create_by(filename: tags[:filename])
      file.update(bit_rate: tags[:bit_rate],
                  duration: tags[:duration],
                  filesize: tags[:filesize],
                  format: tags[:format],
                  mtime: mtime,
                  fileable_id: song_id,
                  fileable_type: "Song")
      file
    end

    def self.add(tags, song_id, options = {})
      new(tags, song_id, options).add
    end

    private
    def mtime
      File.stat(tags[:filename]).mtime
    end
  end
end
