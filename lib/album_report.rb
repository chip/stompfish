require 'csv'

class AlbumReport
  def to_csv
    CSV.generate do |csv|
      csv << column_names
      Album.all.each do |album|
        csv << [album.title, album.artist.name, genre(album), album.year]
      end
    end
  end

  def save
    File.open("album_report.csv", "w+") { |f| f.puts to_csv }
  end

  def self.save
    new.save
  end

  private
  def column_names
    %w(Album Artist Genre Year)
  end

  def genre(album)
    album.genre ? album.genre_name : ""
  end
end
