module PlaylistFormat
  class M3u
    attr_reader :songs

    def initialize(songs)
      @songs = songs
    end

    def to_playlist
      "#{header}\n\n#{songs_info_lines}"
    end

    private
    def header
      "#EXTM3U"
    end

    def info_line_for_song(song)
      "#EXTINF:#{song.duration}, #{song.artist_name} - #{song.title}\n#{song.filename}"
    end

    def songs_info_lines
      songs.inject("") do |str, song|
        str << "#{info_line_for_song(song)}\n\n"
        str
      end
    end
  end
end
